//
//  FavoriteView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 23/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {
    
    @StateObject var favVM = FavoriteViewModel.shared
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(favVM.listArr, id: \.id) { fObj in
                        FavoriteRow(fObj: fObj)
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            VStack {
                HStack{
                    Spacer()
                    Text("Favorites")
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                }
                .padding(.top, .topInsets)
                .background(.white)
                .shadow( color: .black.opacity(0.2), radius: 2)
                Spacer()
                if !favVM.listArr.isEmpty {
                    RoundButton(title: "Add All to Cart")
                        .padding(.horizontal, 20)
                        .padding(.bottom, .bottomInsets + 80)
                }
               
            }
            
            
        }
        .onAppear{
            favVM.serviceCallFavoriteList()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FavoriteView()
}
