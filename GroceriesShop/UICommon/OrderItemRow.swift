//
//  OrderItemRow.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderItemRow: View {
    
    @State var cObj: CartItemModel
    
    var body: some View {
        HStack{
            WebImage(url: URL(string: cObj.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width:  80, height:  80)
            
            VStack (spacing: 4) {
                Text(cObj.name)
                    .font(.customfont(.semibold, fontSize: 18))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                Text("\(cObj.unitValue)\(cObj.unitName), Price")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                    .padding(.bottom, 8)
                
                HStack {
                    Text("QTY: \(cObj.qty) x $\(cObj.price, specifier: "%.2f")")
                        .font(.customfont(.semibold, fontSize: 18))
                    Spacer()
                    Text("$\(cObj.price * Double(cObj.qty),specifier: "%.2f")")
                        .font(.customfont(.semibold, fontSize: 18))
                }
            }
            
        }
    }
}

#Preview {
    OrderItemRow(cObj:  CartItemModel(dict: [
        "order_id": 1,
        "cart_id": 2,
        "user_id": 4,
        "prod_id": 5,
        "qty": 1,
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
        "total_price": 2.99
    ]))
}
