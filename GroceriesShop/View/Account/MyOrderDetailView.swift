//
//  MyOrderDetail.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI


struct MyOrdersView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var myOrderVM = MyOrdersViewModel.shared
   
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(myOrderVM.listArr, id: \.id) { mObj in
                      MyOrderRow(mObj: mObj)
                        .padding(15)
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.15), radius: 2)
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
                    Text("My Order")
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
    MyOrderDetail()
}
