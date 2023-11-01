//
//  PromoCodeRow.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI

struct PromoCodeRow: View {
    @State var promoCodeObj : PromoCodeModel
    var body: some View {
        VStack{
            HStack{
                Text(promoCodeObj.title)
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text(promoCodeObj.code)
                    .font(.customfont(.semibold, fontSize: 12))
                    .foregroundColor(.primaryApp)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.secondaryText.opacity(0.3))
                    .cornerRadius(5)
                
            }
            
            Text(promoCodeObj.description)
                .font(.customfont(.semibold, fontSize: 14))
                .foregroundColor(.secondary)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("Expire Date")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.primaryText)
                    .multilineTextAlignment(.leading)
                
                Text(promoCodeObj.endDate.displayDate(format: "yyyy-MM-dd hh:mm: a"))
                    .font(.customfont(.semibold, fontSize: 12))
                    .foregroundColor(.secondary)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    PromoCodeRow(promoCodeObj: PromoCodeModel(dict: [
        "promo_code_id": 1,
        "code": "SAVE10",
        "title": "Save 20% more",
        "description": "Save 20% more",
        "type": 1,
        "min_order_amount": 5,
        "max_discount_amount": 50,
        "offer_price": 10,
        "start_date": "2023-07-29T17:00:00.000Z",
        "end_date": "2023-11-29T17:00:00.000Z",
        "created_date": "2023-10-23T02:48:50.000Z",
        "modify_date": "2023-10-23T03:02:33.000Z"
    ]))
}
