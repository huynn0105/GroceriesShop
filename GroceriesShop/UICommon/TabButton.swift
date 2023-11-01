//
//  TabButton.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/09/2023.
//

import SwiftUI

struct TabButton: View {
    
    @State var title: String = "Store"
    @State var icon: String = "store_tab"
    
    var isSeleted: Bool = false
    
    var didSelect: ( ()-> ())
    var body: some View {
        Button {
            debugPrint("Tab Button Tap")
            didSelect()
        } label: {
            VStack{
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                Text(title)
                    .font(.customfont(.semibold, fontSize: 14))
            }
        }
        .foregroundColor(isSeleted ? .primaryApp : .primaryText )
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(isSeleted: false) {
            print("test")
        }
    }
}
