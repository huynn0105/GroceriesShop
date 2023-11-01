//
//  GroceriesShopApp.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 21/09/2023.
//

import SwiftUI

@main
struct GroceriesShopApp: App {
    @StateObject var mainVM = MainViewModel.shared
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if mainVM.isUserLogin {
                   MainTabView()
                } else {
                    WelcomeView()
                }
            }
        }
    }
}
