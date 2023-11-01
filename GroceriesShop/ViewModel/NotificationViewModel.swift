//
//  NotificationViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI

class NotificationViewModel: ObservableObject {
    static var shared: NotificationViewModel = NotificationViewModel()
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    @Published var listArr: [NotificationModel] = []
    
    init() {
        serviceCallList()
    }
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_NOTIFICATION_LIST, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return NotificationModel(dict: obj as? NSDictionary ?? [:])
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
