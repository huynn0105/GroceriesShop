//
//  DeliveryAddressView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/10/2023.
//

import SwiftUI

struct DeliveryAddressView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @State var isPicker: Bool = false
    var didSelect: ( (_ aObj: AddressModel) -> () )?
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(addressVM.listArr, id: \.id) { aObj in
                        DeliveryRow(aObj: aObj)
                        .padding(15)
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if isPicker {
                                mode.wrappedValue.dismiss()
                                didSelect?(aObj)
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
                    Text("Delivery Address")
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    NavigationLink{
                        AddDeliveryAddressView()
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
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    
}

#Preview {
    DeliveryAddressView()
}
