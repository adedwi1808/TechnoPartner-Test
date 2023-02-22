//
//  LoginView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        
        VStack {
            Image("TechnoPartnerLogo")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            TPTextFieldView(label: "Email", hint: "Masukkan Email", inputText: $email, textFieldStyle: .email)
            
            TPTextFieldView(label: "Password", hint: "Masukkan Password", inputText: $password, textFieldStyle: .password)
            
            Button {
                //
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
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
