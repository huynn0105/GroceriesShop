//
//  MyOrderDetailViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI

class MyOrderDetailViewModel: ObservableObject {
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var mObj: MyOrderModel = MyOrderModel(dict: [:])
    
    @Published var listArr: [CartItemModel] = []
    
    
    init(mObj: MyOrderModel) {
        self.mObj = mObj
        serviceCallDetail()
    }
    
    
    func serviceCallDetail(){
        ServiceCall.post(parameter: ["order_id": mObj.orderId], path: Globs.SV_MY_ORDER_DETAIL, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    if let payloadObj = response.value(forKey: KKey.payload) as? NSDictionary {
                        self.listArr = (payloadObj.value(forKey: "cart_list") as? NSArray ?? []).map({ obj in
                            return CartItemModel(dict: obj as? NSDictionary ?? [:])
                        })
                    } else {
                        self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                        self.showError = true
                    }
                    
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
