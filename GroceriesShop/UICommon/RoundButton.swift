//
//  RoundButton.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 21/09/2023.
//

import SwiftUI

struct RoundButton: View {
    @State var title: String = "Title"
    var didTap: (()->())?
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.customfont(.semibold, fontSize: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(minWidth: 0,maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                .background(Color.primaryApp)
                .cornerRadius(20)
        }
        
       
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButton()
            .padding(20)
    }
}
