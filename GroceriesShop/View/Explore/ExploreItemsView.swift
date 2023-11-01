//
//  ExploreItemsView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 24/10/2023.
//

import SwiftUI

struct ExploreItemsView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @StateObject var itemsVM = ExploreItemViewModel(catObj: ExploreCategoryModel(dict: [:]))
    
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25,height: 25)
                    }
                    Text(itemsVM.cObj.name)
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    Button {
                        
                    } label: {
                        Image("filter_ic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25,height: 25)
                    }
                }
                
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15, content: {
                        ForEach(itemsVM.listArr, id: \.id) { pObj in
                            ProductCell(pObj: pObj, width: .infinity) {
                                CartViewModel.serviceCallAddToCart(prodId: pObj.productId, qty: 1) { isDone, message in
                                    self.itemsVM.showError = true
                                    self.itemsVM.errorMessage = message
                                }
                            }
                        }
                    })
                    .padding(.vertical, 20)
                    .padding(.bottom, .bottomInsets + 60)
                }
                
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .alert(isPresented: $itemsVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(itemsVM.errorMessage), dismissButton: .default(Text("OK")))
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: ExploreCategoryModel(dict: [
        "cat_id": 1,
        "cat_name": "Frash Fruit & Vegetable",
        "image": "http://localhost:3001/img/category/202310191327522752u0kyi9AjvV.png",
        "color": "F8A44C"
        
    ])))
}
