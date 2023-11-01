//
//  AddPaymentMethodView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 26/10/2023.
//

import SwiftUI


struct AddPaymentMethodView: View {
    
    @StateObject var paymentVM = PaymentViewModel.shared
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: 15){
                    
                    LineTextField(txt: $paymentVM.txtName, title: "Name", placholder: "Enter your name")
                    LineTextField(txt: $paymentVM.txtCardNumber, title: "Card Number", placholder: "Enter your card number", keyboardType: .numberPad)
                    
                    HStack {
                        LineTextField(txt: $paymentVM.txtCardMonth, title: "MM", placholder: "Enter your month", keyboardType: .numberPad)
                        LineTextField(txt: $paymentVM.txtCardYear, title: "YYYY", placholder: "Enter your year", keyboardType: .numberPad)
                    }
                    
                    RoundButton(title: "Add Payment Method"){
                        paymentVM.serviceCallAddToPayment {
                            self.mode.wrappedValue.dismiss()
                        }
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
            }
            
            VStack {
                HStack{
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }, label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    })
                    Spacer()
                    Text("Add Payment Method")
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(.white)
                .shadow( color: .black.opacity(0.2), radius: 2)
                Spacer()
            }
        }
       
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}
#Preview {
    AddPaymentMethodView()
}
