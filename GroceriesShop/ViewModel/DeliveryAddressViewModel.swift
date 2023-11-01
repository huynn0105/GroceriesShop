//
//  DeliveryAddressViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/10/2023.
//

import Foundation

class DeliveryAddressViewModel: ObservableObject {
    static var shared: DeliveryAddressViewModel = DeliveryAddressViewModel()
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var txtName: String = ""
    @Published var txtMobile: String = ""
    @Published var txtAddress: String = ""
    @Published var txtCity: String = ""
    @Published var txtState: String = ""
    @Published var txtPostalCode: String = ""
    @Published var txtTypeName: String = "Home"
    
    
    @Published var listArr: [AddressModel] = []
    
    init() {
        serviceCallList()
    }
    
    func clearAll(){
        txtName = ""
        txtMobile = ""
        txtAddress = ""
        txtCity = ""
        txtState = ""
        txtPostalCode = ""
        txtTypeName = ""
    }
    
    func setData(aObj: AddressModel){
        txtName = aObj.name
        txtMobile = aObj.phone
        txtAddress = aObj.address
        txtCity = aObj.city
        txtState = aObj.state
        txtPostalCode = aObj.postalCode
        txtTypeName = aObj.typeName
    }
    
    func serviceCallList(){
        ServiceCall.post(parameter: [:], path: Globs.SV_DELIVERY_ADDRESS_LIST, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return AddressModel(dict: obj as? NSDictionary ?? [:])
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
    
    func serviceCallUpdateAddresss(eObj: AddressModel?, didDone: (()->())? ){
        ServiceCall.post(parameter: [ "address_id": eObj?.addressId ?? "",
                                      "name":txtName,
                                      "type_name": txtTypeName,
                                      "phone":txtMobile,
                                      "address":txtAddress,
                                      "city":txtCity,
                                      "state":txtState,
                                      "postal_code":txtPostalCode], path: Globs.SV_UPDATE_DELIVERY_ADDRESS, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    didDone?()
                    self.clearAll()
                    self.serviceCallList()
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
    
    func serviceCallRemoveAddress(aObj: AddressModel, didDone: (()->())? ){
        ServiceCall.post(parameter: [
            "address_id": aObj.addressId
        ],
                         path: Globs.SV_DELETE_DELIVERY_ADDRESS, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    didDone?()
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
    
    
    func serviceCallAddToAddress(didDone: (()->())? ) {
        ServiceCall.post(
            parameter: [
                "name":txtName,
                "type_name": txtTypeName,
                "phone":txtMobile,
                "address":txtAddress,
                "city":txtCity,
                "state":txtState,
                "postal_code":txtPostalCode],
            path: Globs.SV_ADD_DELIVERY_ADDRESS,
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
