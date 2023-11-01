//
//  ProductDetailView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 23/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProductDetailView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    
    @StateObject var detailVM: ProductDetailViewModel = ProductDetailViewModel(prodObj: ProductModel(dict: [:]))
    
    var body: some View {
        ZStack{
            
     
        ScrollView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(hex: "F2F2F2"))
                    .frame(width: .screenWidth, height: .screenWidth  * 0.8)
                    .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
                
                
                WebImage(url: URL(string: detailVM.pObj.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
            }
            .frame(width: .screenWidth, height: .screenWidth * 0.8)
            
            VStack {
                HStack {
                    Text(detailVM.pObj.name)
                        .font(.customfont(.semibold, fontSize: 24))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Button {
                        detailVM.serviceCallAddRemoveFavorite()
                    } label: {
                        Image(detailVM.isFav ? "favorite" : "fav")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .foregroundColor(.secondaryText)
                }
                
                Text("\(detailVM.pObj.unitValue)\(detailVM.pObj.unitName), Price")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                
                
                HStack {
                    Button {
                        detailVM.addSubQTY(isAdd: false)
                    } label: {
                        Image("subtack")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(10)
                    }
                    .foregroundColor(.secondaryText)
                    Text("\(detailVM.qty)")
                        .font(.customfont(.semibold, fontSize: 24))
                        .foregroundColor(.primaryText)
                        .frame(width: 45, height: 45, alignment: .center)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
                        }
                    Button {
                        detailVM.addSubQTY(isAdd: true)
                    } label: {
                        Image("add_green")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(10)
                    }
                    .foregroundColor(.secondaryText)
                    Spacer()
                    Text("$\((detailVM.pObj.offerPrice ?? detailVM.pObj.price) * Double(detailVM.qty), specifier: "%.2f")")
                        .font(.customfont(.medium, fontSize: 28))
                        .foregroundColor(.primaryText)
                }
                
                VStack {
                    HStack {
                        Text("Product Detail")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button{
                            withAnimation {
                                detailVM.showDetail()
                            }
                        } label: {
                            Image(detailVM.isShowDetail ? "detail_open" : "next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(.secondaryText)
                    }
                    if detailVM.isShowDetail {
                        Text(detailVM.pObj.detail)
                            .font(.customfont(.medium, fontSize: 13))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                    }
                    
                }
                
                Divider()
                VStack {
                    HStack {
                        Text("Nutritions")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Text(detailVM.pObj.nutritionWeight)
                            .font(.customfont(.semibold, fontSize: 10))
                            .foregroundColor(.secondary)
                            .padding(8)
                            .background(Color.placeholder.opacity(0.5))
                        
                        Button{
                            withAnimation {
                                detailVM.showNutrition()
                            }
                        } label: {
                            Image(detailVM.isShowNutrition ? "detail_open" : "next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(.secondaryText)
                    }
                    if detailVM.isShowNutrition {
                        LazyVStack {
                            ForEach(detailVM.nutritionArr, id: \.id) {
                                nObj in
                                HStack {
                                    Text(nObj.nutritionName)
                                        .font(.customfont(.semibold, fontSize: 15))
                                        .foregroundColor(.secondary)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(nObj.nutritionValue)
                                        .font(.customfont(.semibold, fontSize: 15))
                                        .foregroundColor(.primaryText)
                                    
                                }
                                
                            }
                            .padding(.vertical, 10)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                }
                Divider()
                VStack {
                    HStack {
                        Text("Review")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                       
                        HStack(spacing: 4) {
                            ForEach( 1...5, id: \.self) { index in
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.orange)
                                    .frame(width: 20, height: 20)
                            }
                        }
                       
                        Button{
                            
                        } label: {
                            Image("next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(.secondaryText)
                    }
                    if detailVM.isShowDetail {
                        Text(detailVM.pObj.detail)
                            .font(.customfont(.medium, fontSize: 13))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0
                                   , maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                    }
                    
                }
                
              
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            

            
            RoundButton(title: "Add to Basket") {
                CartViewModel.serviceCallAddToCart(prodId: detailVM.pObj.productId, qty: detailVM.qty) { isDone, message in
                    detailVM.qty = 1
                    self.detailVM.errorMessage = message
                    self.detailVM.showError = true
                }
            }
            .padding(20)
        }
      
               
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
                            Spacer()
                            Button {
                               
                            } label: {
                                Image("share")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25,height: 25)
                            }
                        }
                       

                        Spacer()

                    }
                    .padding(.top, .topInsets)
                    .padding(.horizontal, 20)
        }
        .alert(isPresented: $detailVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(detailVM.errorMessage)
                  , dismissButton: .default(Text("OK"))
            )
            
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()

    }
    
}

#Preview {
    ProductDetailView(
        detailVM: ProductDetailViewModel(
            prodObj: ProductModel(
                dict: ["offer_price": 2.49,
                       "start_date": "2023-10-09T17:00:00.000Z",
                       "end_date": "2023-11-09T17:00:00.000Z",
                       "prod_id": 1,
                       "cat_id": 1,
                       "brand_id": 1,
                       "type_id": 1,
                       "name": "Red Apple",
                       "detail": "abcadad dadad",
                       "unit_name": "kg",
                       "unit_value": "1",
                       "nutrition_weight": "200g",
                       "price": 2.99,
                       "image": "http://localhost:3001/img/product/202310191511281128bRf7qx3Riw.png",
                       "cat_name": "Frash Fruit & Vegetable",
                       "type_name": "Pulses",
                       "is_fav": 0])))
}
