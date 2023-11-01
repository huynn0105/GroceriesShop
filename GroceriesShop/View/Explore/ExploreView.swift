//
//  ExploreView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/09/2023.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var exploreVM: ExploreViewModel = ExploreViewModel.shared
    
    var columns = [
        GridItem(.flexible(),spacing: 20),
        GridItem(.flexible(),spacing: 20)
    ]
    @State var txtSearch : String = ""
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Spacer()
                       Text("Find Products")
                           .font(.customfont(.semibold, fontSize: 20))
                           .frame(height: 46)
                       Spacer()
                }
                .padding(.top, .topInsets)
                SearchTextField(txt: $txtSearch, placholder: "Search Store")
                    .padding(.horizontal,20)
                    .padding(.bottom, 4)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(exploreVM.listArr, id: \.id) {
                            cObj in
                            NavigationLink {
                                ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: cObj))
                            } label: {
                                ExploreCategoryCell(cObj: cObj)
                                    .aspectRatio(0.95, contentMode: .fill)
                            }

                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
      
        }
        .ignoresSafeArea()
    }
    
    
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
