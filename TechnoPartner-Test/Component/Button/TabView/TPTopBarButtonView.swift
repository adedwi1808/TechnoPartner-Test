//
//  TPTopBarButtonView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct TPTopBarButtonView: View {
    var tabs: [String]
    var fixed: Bool = true
    var geoWidth: CGFloat
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self){ row in
                            Button {
                                withAnimation {
                                    selectedTab = row
                                }
                            } label: {
                                VStack(spacing: 0) {
                                    Text(tabs[row])
                                        .foregroundColor(selectedTab == row ? .black : .gray)
                                        .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)): .none, height: 47)
                                    
                                    Rectangle()
                                        .fill(selectedTab == row ? .gray : .clear)
                                        .frame(height: 2)
                                }
                                .fixedSize()
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 49)
        .onAppear(perform: {
            UIScrollView.appearance().backgroundColor = .white
            UIScrollView.appearance().bounces = fixed ? false : true
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}

struct TPTopBarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TPTopBarButtonView(tabs: ["Seasonal Product", "Best Seller", "adada", "adada", "adada"], geoWidth: 1000, selectedTab: .constant(0))
    }
}

