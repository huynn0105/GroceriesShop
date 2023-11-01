//
//  SectionTitleAll.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/09/2023.
//

import SwiftUI

struct SectionTitleAll: View {
    @State var title: String = "Title"
    @State var titleAll: String = "View All"
    var didTab: ( ()-> ())?
    var body: some View {
        HStack{
            Text(title).font(.customfont(.semibold, fontSize: 24))
                .foregroundColor(.primaryText)
            Spacer()
            Text(titleAll)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.primaryApp)
        }
        .frame(height: 40)
    }
}

struct SectionTitleAll_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleAll()
    }
}
