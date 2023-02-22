//
//  LoginView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    var body: some View {
        VStack {
            NavigationLink(destination: TabBarView(), isActive: $loginVM.isLogined, label: {EmptyView()})
            
            Image("TechnoPartnerLogo")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            TPTextFieldView(label: "Email", hint: "Masukkan Email", inputText: $loginVM.username, textFieldStyle: .email)
            
            TPTextFieldView(label: "Password", hint: "Masukkan Password", inputText: $loginVM.password, textFieldStyle: .password)
            
            Button {
                Task {
                    try await loginVM.doLogin()
                }
            } label: {
                Text("Login")
                    .buttonStyle(.bordered)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.top, 20)
            }

            Spacer()
        }
        .padding(15)
        .onAppear {
            UserDefaults().resetLocale()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
