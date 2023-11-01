//
//  FavoriteRow.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 23/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRow: View {
    
    @State var fObj : ProductModel = ProductModel(dict: [:])
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: fObj.image))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width:  60, height:  60)
                
                VStack(spacing: 4) {
                    Text(fObj.name)
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                    Text("\(fObj.unitValue)\(fObj.unitName), Price")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                    
                    
                }
                Text("$\(fObj.offerPrice ?? fObj.price, specifier: "%.2f" )")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0,maxWidth: .infinity, alignment: .leading)

                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            Divider()
        }
    }
}

#Preview {
    FavoriteRow()
}
