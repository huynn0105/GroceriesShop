//
//  MainTabView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/09/2023.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        ZStack{
            if homeVM.selectTab == 0 {
                HomeView()
            } else if homeVM.selectTab == 1 {
                ExploreView()
            } else if homeVM.selectTab == 2 {
                MyCartView()
            } else if homeVM.selectTab == 3 {
                FavoriteView()
            } else if homeVM.selectTab == 4 {
                AccountView()
            }
            
            VStack {
                Spacer()
                HStack {
                    TabButton(title: "Shop", icon: "store_tab",isSeleted: homeVM.selectTab == 0) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 0
                            }
                        }
                    }
                    TabButton(title: "Explore", icon: "explore_tab",isSeleted: homeVM.selectTab == 1) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 1
                            }
                        }
                    }
                    TabButton(title: "Cart", icon: "cart_tab",isSeleted: homeVM.selectTab == 2) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 2
                            }
                        }
                    }
                    TabButton(title: "Favourite", icon: "fav_tab",isSeleted: homeVM.selectTab == 3) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 3
                            }
                        }
                    }
                    TabButton(title: "Account", icon: "account_tab",isSeleted: homeVM.selectTab == 4) {
                        DispatchQueue.main.async {
                            withAnimation {
                                homeVM.selectTab = 4
                            }
                        }
                    }
                    
                }
                .padding(.bottom, .bottomInsets)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .cornerRadius(15)
                .background(.white)
                .shadow(color: .black.opacity(0.005), radius: 3 , x: 0, y: -2)
            }
            

        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
