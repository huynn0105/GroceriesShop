//
//  CheckoutView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 26/10/2023.
//

import SwiftUI

struct CheckoutView: View {
    @Binding var isShow: Bool
    @StateObject var cartVM = CartViewModel.shared
    var body: some View {
        VStack{
            
            Spacer()
            VStack{
                HStack{
                    
                    Text("Checkout")
                        .font(.customfont(.semibold, fontSize: 18))
                        .frame(height: 46)
                    Spacer()
                    
                    Button {
                        $isShow.wrappedValue = false
                    } label: {
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.top, 30)
                
                Divider()
                VStack{
                    HStack {
                        Text("Delivery Type")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondary)
                            .frame(height: 46)
                        
                        Spacer()
                        Picker("", selection: $cartVM.deliveryType) {
                            Text("Delivery").tag(1)
                            Text("Collection").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 180)
                    }
                    Divider()
                    
                    if cartVM.deliveryType == 1 {
                        NavigationLink {
                            DeliveryAddressView(isPicker: true, didSelect: {
                                aObj in
                                cartVM.deliveryObj = aObj
                            })
                        } label: {
                            HStack {
                                Text("Delivery")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.secondary)
                                    .frame(height: 46)
                                
                                Spacer()
                                Text(cartVM.deliveryObj?.name ?? "Select method")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(height: 46)
                                Image("next")
                                    .resizable()
                                
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.primaryText)
                                
                            }
                        }
                 
                        Divider()
                    }
                    
                    HStack {
                        Text("Payment Type")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.secondary)
                            .frame(height: 46)
                        
                        Spacer()
                        Picker("", selection: $cartVM.paymentType) {
                            Text("COD").tag(1)
                            Text("Online").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 180)
                    }
                    Divider()
                    if cartVM.paymentType == 1 {
                        NavigationLink {
                            PaymentMethodView(isPicker: true, didSelect: {
                                pObj in
                                cartVM.paymentObj = pObj
                            })
                        } label: {
                            HStack {
                                Text("Payment")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.secondary)
                                    .frame(height: 46)
                                
                                Spacer()
                                Text(cartVM.paymentObj?.cardNumber ?? "Select")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                    .frame(height: 46)
                                Image("master")
                                    .resizable()
                                
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.primaryText)
                                
                            }
                        }
                        Divider()
                    }
                    NavigationLink {
                        PromoCodeView(isPicker: true, didSelect: {
                            pObj in
                            cartVM.promoCodeObj = pObj
                        })
                    } label: {
                        HStack {
                            Text("Promo Code")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.secondary)
                                .frame(height: 46)
                            
                            Spacer()
                            Text(cartVM.promoCodeObj?.code ?? "Pick Discount")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(height: 46)
                            Image("next")
                                .resizable()
                            
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.primaryText)
                            
                        }
                    }
                    Divider()
                }
                
                VStack{
                    HStack {
                        Text("Total")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("$\(cartVM.total)")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.secondary)
                    }
                    HStack{
                        Text("Delivery Cost")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        Text("+ $\(cartVM.deliverPriceAmount)")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.secondary)
                    }
                    HStack{
                        Text("Discount")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        Text("- $\(cartVM.discountPriceAmount)")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.red)
                    }
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                HStack {
                    Text("Final Total")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.secondary)
                        .frame(height: 46)
                    
                    Spacer()
                    Text("$\(cartVM.userPayAmount)")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(height: 46)
                    
                    
                }
                Divider()
                VStack{
                    Text("By continuing you agree to our")
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    
                    HStack{
                        Text("Terms of Service")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                        
                        Text(" and ")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.secondary)
                        
                        Text("Privacy Policy")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    
                }  .padding(.vertical, .screenWidth * 0.03)
                
                RoundButton(title: "Place Order"){
                    cartVM.serviceCallOrderPlace()
                }
                    .padding(.bottom, .bottomInsets + 70)
                
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(20, corner: [.topLeft, .topRight])
            
        }
    }
}

#Preview {
   
    NavigationView {
        CheckoutView(isShow: Binding.constant(false))
    }
}
