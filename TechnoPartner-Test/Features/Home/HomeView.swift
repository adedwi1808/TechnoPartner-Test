//
//  HomeView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    var body: some View {
        ZStack {
            NavigationLink(destination: DetailQRView(qrLink: homeVM.qrcode), isActive: $homeVM.openDetailQR, label: {EmptyView()})
            
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    userInformationView
                    
                    carouselView
                    Spacer()
                }
            }
            .refreshable {
                Task {
                    try await homeVM.getHomeData()
                }
            }
        }
        .onAppear {
            Task {
                try await homeVM.getHomeData()
            }
            homeVM.updateTimer
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//MARK: - Carousel / Presentation View

extension HomeView {
    @ViewBuilder
    private var carouselView: some View {
        VStack{
            TabView(selection: $homeVM.index) {
                ForEach((0..<homeVM.banner.count), id: \.self) { index in
                    AsyncImage(url: URL(string: homeVM.banner[index])) { image in
                        image.resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(systemName: "photo")
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut)
            .transition(.slide)
            
            Spacer()
            
            HStack {
                HStack(spacing: 5) {
                    ForEach((0..<3), id: \.self) { index in
                        Circle()
                            .fill(index == self.homeVM.index ? Color.black : Color.gray.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding()
                
                Spacer()
                
                Button {
                    //
                } label: {
                    Text("View All")
                        .foregroundColor(.green)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }

            }
        }
        .frame(height: 280)
        .background(.white)
    }
}

//MARK: - User Information
extension HomeView {
    @ViewBuilder
    private var userInformationView: some View {
        ZStack(alignment: .center) {
            Image("BackgroundTextureImage")
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 15) {
                Text("\(homeVM.greeting),")
                
                Text(homeVM.name)
                    .fontWeight(.bold)
                
                HStack {
                    
                    AsyncImage(url: URL(string: homeVM.qrcode)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        Image(systemName: "photo")
                    }
                    .frame(width: 80, height: 80)
                    .background(.white)
                    .cornerRadius(40)
                    .shadow(radius: 5)
                    .onTapGesture {
                        withAnimation {
                            homeVM.openDetailQR.toggle()
                        }
                    }

                    
                    VStack(alignment: .leading) {
                        Text("Saldo")
                        
                        Text("Points")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(String(homeVM.saldo))
                            .fontWeight(.bold)
                        
                        Text(String(homeVM.point))
                            .foregroundColor(.green)
                            .fontWeight(.medium)
                    }
                }
            }
            .padding()
            .background(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2),radius: 2, y: 4)
            .padding()
        }
    }
}
