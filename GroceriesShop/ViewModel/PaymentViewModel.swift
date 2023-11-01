//
//  PaymentViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 26/10/2023.
//

import Foundation
class PaymentViewModel: ObservableObject {
    static var shared: PaymentViewModel = PaymentViewModel()
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var txtName: String = ""
    @Published var txtCardNumber: String = ""
    @Published var txtCardMonth: String = ""
    @Published var txtCardYear: String = ""
    
    @Published var listArr: [PaymentModel] = []
    
    init() {
        serviceCallList()
    }
    
    func clearAll(){
        txtName = ""
        txtCardNumber = ""
        txtCardMonth = ""
        txtCardYear = ""
        
    }
    
    func serviceCallList(){
        
        ServiceCall.post(parameter: [:], path: Globs.SV_PAYMENT_METHOD_LIST, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return PaymentModel(dict: obj as? NSDictionary ?? [:])
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
    
    
    
    func serviceCallRemovePayment(pObj: PaymentModel){
        ServiceCall.post(parameter: [
            "pay_id": pObj.payId
        ],
                         path: Globs.SV_REMOVE_PAYMENT_METHOD, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.clearAll()
                    self.serviceCallList()
                }
                else {
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription as? String ?? "Fail"
            self.showError = true
        }
        
    }
    
    
    func serviceCallAddToPayment(didDone: (()->())? ) {
        if txtName.isEmpty {
            errorMessage = "Please enter name"
            showError = true
            return
        }
        if txtCardNumber.count != 16 {
            errorMessage = "Please enter valid card number"
            showError = true
            return
        }
        if txtCardMonth.count != 2 {
            errorMessage = "Please enter valid card month"
            showError = true
            return
        }
        if txtCardYear.count != 4 {
            errorMessage = "Please enter valid card year"
            showError = true
            return
        }
        ServiceCall.post(
            parameter: [
                "name":txtName,
                "card_number": txtCardNumber,
                "card_month":txtCardMonth,
                "card_year":txtCardYear
            ],
            path: Globs.SV_ADD_PAYMENT_METHOD,
            isToken: true) { responseObj in
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        self.clearAll()
                        self.serviceCallList()
                        didDone?()
                    }
                    else {
                        self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                        self.showError = true
                    }
                }
            } failure: { error in
                self.errorMessage = error?.localizedDescription as? String ?? "Fail"
                self.showError = true
            }
    }
}
