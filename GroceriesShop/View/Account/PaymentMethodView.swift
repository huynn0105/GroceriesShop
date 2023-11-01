//
//  PaymentMethodView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 26/10/2023.
//

import SwiftUI

struct PaymentMethodView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var paymentVM = PaymentViewModel.shared
    @State var isPicker: Bool = false
    var didSelect: ( (_ pObj: PaymentModel) -> () )?
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(paymentVM.listArr, id: \.id) { pObj in
                        HStack(spacing: 15){
                            Image("paymenth_methods")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            VStack(spacing: 4){
                               
                                    Text(pObj.name)
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                Text("**** **** **** \(pObj.cardNumber)")
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.primaryApp)
                                    .multilineTextAlignment(.leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                            Button {
                                paymentVM.serviceCallRemovePayment(pObj: pObj)
                            } label: {
                                Image("close")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            
                        }
                        .padding(15)
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if isPicker {
                                mode.wrappedValue.dismiss()
                                didSelect?(pObj)
                            }
                        }
                        
                        
                        
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
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
                    Text("Payment Method")
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    NavigationLink{
                        AddPaymentMethodView()
                    } label: {
                        Image("add_green")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    }
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(.white)
                .shadow( color: .black.opacity(0.2), radius: 2)
                Spacer()
                
            }
            
            
        }
        .alert(isPresented: $paymentVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(paymentVM.errorMessage))
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}


#Preview {
    PaymentMethodView()
}
