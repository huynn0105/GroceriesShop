//
//  FavoriteViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 23/10/2023.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    static var shared: FavoriteViewModel = FavoriteViewModel()
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var listArr: [ProductModel] = []
    
    init() {
        serviceCallFavoriteList()
    }
    
    func serviceCallFavoriteList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_FAVORITE_LIST, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return ProductModel(dict: obj as? NSDictionary ?? [:])
                    })
                    
                    
                }
                else {
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }

    }
}
