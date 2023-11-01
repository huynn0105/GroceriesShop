//
//  OrderAcceptedView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 26/10/2023.
//

import SwiftUI

struct OrderAcceptedView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        ZStack{
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            VStack{
                Spacer()
                Image("order_accpeted")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .screenWidth * 0.7)
                
                Text("Your Order has been\naccepted")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.semibold, fontSize: 28))
                    .padding(.bottom, 12)
                Text("Your items has been placed and is on\n it's way to being processed")
                    .multilineTextAlignment(.center)
                    .font(.customfont(.regular, fontSize: 18))
                    .foregroundColor(.secondary)
                
                Spacer()
                Spacer()
                RoundButton(title: "Track Order")
                
                NavigationLink{
                    
                } label: {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Text("Back to home")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.primaryApp)
                            .padding(.vertical, 15)
                    }
                    .padding(.bottom, .bottomInsets + 15)
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    OrderAcceptedView()
}
