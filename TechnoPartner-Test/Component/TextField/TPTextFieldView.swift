//
//  TPTextFieldView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct TPTextFieldView: View {
    enum TextFieldStyle {
        case email
        case password
    }
    
    @State var label: String
    @State var hint: String
    @Binding var inputText: String
    @State var withShadow: Bool = false
    @State var textFieldStyle: TextFieldStyle = .password
    @State private var isShowPassword: Bool = false
    @State var isValid: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            HStack {
                switch textFieldStyle {
                case .email:
                    TextField(hint, text: $inputText)
                        .onChange(of: inputText) {
                            if !$0.isEmpty,
                               $0.isValidEmail() {
                                isValid = true
                            } else {
                                isValid = false
                            }
                        }
                case .password:
                    
                    if isShowPassword {
                        TextField(hint, text: $inputText)
                    } else {
                        SecureField(hint, text: $inputText)
                    }
                    
                    Button {
                        isShowPassword.toggle()
                    } label: {
                        Image(systemName: isShowPassword ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                    }
                    
                }
            }
            .frame(height: 40)
            .padding(5)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 8)
                    .stroke( .gray.opacity(0.2), lineWidth: 1)
                    .shadow(radius: 5)
            })
        }
    }
}

struct TPTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TPTextFieldView(label: "Email", hint: "Masukkan email", inputText: .constant("adedwip1808@"))
    }
}
