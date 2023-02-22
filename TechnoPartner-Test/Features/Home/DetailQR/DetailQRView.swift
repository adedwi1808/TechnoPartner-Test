//
//  DetailQRView.swift
//  TechnoPartner-Test
//
//  Created by Ade Dwi Prayitno on 22/02/23.
//

import SwiftUI

struct DetailQRView: View {
    @Environment(\.dismiss) var dismiss
    
    var qrLink: String = ""
    var body: some View {
        VStack {
            Text("Show the QR code below to the cashier.")
            
            AsyncImage(url: URL(string: qrLink)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "photo")
            }

        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }

            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailQRView_Previews: PreviewProvider {
    static var previews: some View {
        DetailQRView()
    }
}
