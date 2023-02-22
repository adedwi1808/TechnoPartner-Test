//
//  HomeView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var index = 0
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                userInformationView
                
                carouselView
                Spacer()
            }
        }
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
            TabView(selection: $index) {
                ForEach((0..<3), id: \.self) { index in
                    Color.red
                        .frame(height: 230)
                        .border(Color.black)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer()
            
            HStack {
                HStack(spacing: 5) {
                    ForEach((0..<3), id: \.self) { index in
                        Circle()
                            .fill(index == self.index ? Color.black : Color.gray.opacity(0.5))
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
                Text("Good Afteernoon,")
                
                Text("Guntur Saputro")
                    .fontWeight(.bold)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Saldo")
                        
                        Text("Points")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Rp 249.000")
                            .fontWeight(.bold)
                        
                        Text("2.500")
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
