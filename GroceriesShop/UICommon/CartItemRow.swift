//
//  CartItemRow.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/10/2023.
//

//

import SwiftUI
import SDWebImageSwiftUI

struct CartItemRow: View {
    
    var cObj : CartItemModel = CartItemModel(dict: [:])
    
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: cObj.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width:  60, height:  60)
                
                VStack(spacing: 4) {
                    HStack{
                        Text(cObj.name)
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                        
                        Button{
                            CartViewModel.shared.serviceCallRemoveCart(cObj: cObj)
                        } label: {
                            Image("close")
                                .resizable()
                                .frame(width: 18, height: 18)
                        }
                    }
                    Text("\(cObj.unitValue)\(cObj.unitName), Price")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                        .padding(.bottom, 8)
                    HStack{
                        
                        Button {
                            CartViewModel.shared.serviceCallUpdateCart(cObj: cObj, newQty: cObj.qty - 1)
                        } label: {
                            Image("subtack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .padding(4)
                        .foregroundColor(.secondaryText)
                        
                        Text("\(cObj.qty)")
                            .font(.customfont(.semibold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .frame(width: 45, height: 45, alignment: .center)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.placeholder.opacity(0.5), lineWidth: 1)
                            }
                        Button {
                            CartViewModel.shared.serviceCallUpdateCart(cObj: cObj, newQty: cObj.qty + 1)
                        } label: {
                            Image("add_green")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .padding(4)
                        .foregroundColor(.secondaryText)
                        Spacer()
                        Text("$\(cObj.offerPrice ?? cObj.price, specifier: "%.2f" )")
                            .font(.customfont(.semibold, fontSize: 20))
                            .foregroundColor(.primaryText)
                        
                    }
                }
            }
            Divider()
        }
    }
}


#Preview {
    CartItemRow(cObj: CartItemModel(dict: [        "cart_id": 7,
                                                   "user_id": 4,
                                                   "prod_id": 5,
                                                   "qty": 6,
                                                   "cat_id": 1,
                                                   "brand_id": 1,
                                                   "type_id": 1,
                                                   "name": "Organic Banana",
                                                   "detail": "Banana Banana Banana Banana Banana",
                                                   "unit_name": "pcs",
                                                   "unit_value": "7",
                                                   "nutrition_weight": "200g",
                                                   "price": 2.99,
                                                   "created_date": "2023-10-20T07:21:13.000Z",
                                                   "modify_date": "2023-10-20T07:21:13.000Z",
                                                   "cat_name": "Frash Fruit & Vegetable",
                                                   "is_fav": 1,
                                                   "brand_name": "big pro",
                                                   "type_name": "Pulses",
                                                   "offer_price": 2.99,
                                                   "start_date": "",
                                                   "end_date": "",
                                                   "is_offer_active": 0,
                                                   "image": "http://localhost:3001/img/product/202310201251135113XBYXQLjdjL.png",
                                                   "item_price": 2.99,
                                                   "total_price": 17.94
                                          ]))
}
