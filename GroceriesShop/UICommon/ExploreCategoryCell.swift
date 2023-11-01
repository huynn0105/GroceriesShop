//
//  ExploreCategoryCell.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 24/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ExploreCategoryCell: View {
    @State var cObj: ExploreCategoryModel = ExploreCategoryModel(dict: [:])
   
    var didAddCart: ( ()-> () )?
    
    var body: some View {
        VStack{
            WebImage(url: URL(string: cObj.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 120,height: 90)
            Spacer()
            Text(cObj.name)
                .font(  .customfont(.semibold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            Spacer()
            
          

        }
        .padding(15)
        .background(cObj.color.opacity(0.3))
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(cObj.color, lineWidth: 1)
        }
    }
}

#Preview {
    ExploreCategoryCell(cObj: ExploreCategoryModel(dict: [
        "cat_id": 1,
            "cat_name": "Frash Fruit & Vegetable",
            "image": "http://localhost:3001/img/category/202310191327522752u0kyi9AjvV.png",
        "color": "F8A44C"])) {
            
        }
}
