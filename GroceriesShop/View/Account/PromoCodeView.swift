//
//  PromoCodeView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/10/2023.
//

import SwiftUI

struct PromoCodeView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var promoCodeVM = PromoCodeViewModel.shared
    @State var isPicker: Bool = false
    var didSelect: ( (_ pObj: PromoCodeModel) -> () )?
    var body: some View {
        ZStack{
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(promoCodeVM.listArr, id: \.id) { promoCodeObj in
                        PromoCodeRow(promoCodeObj: promoCodeObj)
                        .padding(15)
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if isPicker {
                                mode.wrappedValue.dismiss()
                                didSelect?(promoCodeObj)
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
                    Text("Promo Code")
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
    PromoCodeView()
}
