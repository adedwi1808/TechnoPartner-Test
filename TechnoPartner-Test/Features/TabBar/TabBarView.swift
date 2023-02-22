//
//  TabBarView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab: Tab = .home
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(Tab.home)
            
            MenuView()
                .tabItem {
                    VStack {
                        Image(systemName: "doc.plaintext")

                        Text("Menu")
                    }
                }
                .tag(Tab.menu)
        }
        .navigationTitle(selectedTab.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
//        .tint(Color("PrimaryColor"))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

extension TabBarView {
    enum Tab: String {
        case home = "Home"
        case menu = "Menu"
    }
}
