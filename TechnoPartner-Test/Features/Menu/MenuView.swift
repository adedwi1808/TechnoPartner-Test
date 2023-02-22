//
//  MenuView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct MenuView: View {
    @StateObject var menuVM: MenuViewModel = MenuViewModel()
    @State var selectedTab: Int = 0
    @State var contentSize: CGSize = .zero
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TPTopBarButtonView(tabs: menuVM.menusCategory, geoWidth: .init(1000), selectedTab: $selectedTab)
            
            Spacer()
            menusView
        }
        .background(Color("BackgroundColor"))
        .navigationTitle("MENU")
        .onAppear {
            if !menuVM.isLoaded{
                Task {
                    try await menuVM.getMenusData()
                }
            }
        }
    }
}

//MARK: - MenusView
extension MenuView {
    @ViewBuilder
    private var menusView: some View {
        
        ScrollView(showsIndicators: false) {
            ScrollViewReader { scrollVal in
                ForEach(menuVM.menus, id: \.self) { category in
                    Text(category.categoryName)
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .id(category.categoryName)
                    menuItemView(category: category)
                }
                .onChange(of: selectedTab) { newValue in
                    withAnimation {
                        scrollVal.scrollTo(menuVM.menus[selectedTab], anchor: .top)
                    }
                }
            }
            .padding(.horizontal, 15)
            .background(Color("BackgroundColor"))
        }
        .onAppear {
            UITabBar.appearance().isHidden = true
        }
    }
    
    @ViewBuilder
    private func menuItemView(category: MenuCategory) -> some View {
        VStack(spacing: 0) {
            ForEach(category.menu, id: \.name) { menu in
                if category.menu[0].name != menu.name {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 0.1, dash: [5]))
                        .frame(height: 1)
                }
                
                HStack {
                    AsyncImage(url: URL(string: menu.photo.replacingOccurrences(of: " ", with: "%20")), content: { image in
                        image.resizable()
                    }, placeholder: {
                        Image(systemName: "photo")
                    })
                    .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading) {
                        Text(menu.name)
                            .font(Font.system(size: 14, weight: .medium))
                        Text(menu.description)
                            .font(Font.system(size: 12, weight: .light))
                            .foregroundColor(.gray)
                            .lineLimit(3)
                    }
                    
                    Spacer()
                    Text("\(menu.price)")
                        .font(Font.system(size: 16, weight: .medium))
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding()
                }
                .background(.white)
            }
        }
        
    }
}



struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
