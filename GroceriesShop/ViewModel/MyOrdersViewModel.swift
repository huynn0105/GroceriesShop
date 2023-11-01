//
//  MyOrdersViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 26/10/2023.
//

import SwiftUI

class MyOrdersViewModel: ObservableObject {
    static var shared: MyOrdersViewModel = MyOrdersViewModel()
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    @Published var listArr: [MyOrderModel] = []
    
    init() {
        serviceCallList()
    }
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_MY_ORDER, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return MyOrderModel(dict: obj as? NSDictionary ?? [:])
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
