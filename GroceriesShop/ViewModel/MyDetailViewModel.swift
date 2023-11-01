//
//  MyDetailViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import Foundation
import CountryPicker

class MyDetailViewModel: ObservableObject {
    static var shared: MyDetailViewModel = MyDetailViewModel()
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var txtName: String = ""
    @Published var txtUserName: String = ""
    @Published var txtMobile: String = ""
    @Published var txtMobileCode: String = ""
    @Published var txtCurrentPassword: String = ""
    @Published var txtNewPassword: String = ""
    @Published var txtConfirmPassword: String = ""
    @Published var isCurrentPassword: Bool = false
    @Published var isNewPassword: Bool = false
    @Published var isConfirmPassword: Bool = false
    @Published var countryObj: Country? {
        didSet {
            if countryObj != nil {
                txtMobileCode = "+\(countryObj?.phoneCode)"
            }
        }
    }

    
    @Published var listArr: [NotificationModel] = []
    @Published var userObj: UserModel = UserModel(dict: [:])
    
    
    func clearAll(){
        txtName = ""
        txtUserName = ""
        txtMobile = ""
        txtMobileCode = ""
        txtCurrentPassword = ""
        txtNewPassword = ""
        txtConfirmPassword = ""
        isNewPassword = false
        isConfirmPassword = false
        isCurrentPassword = false
    }
    
    func setData(){
        var userObj = MainViewModel.shared.userObj
        txtName = userObj.name
        txtMobile = userObj.mobile
        txtMobileCode = userObj.mobileCode
        txtUserName = userObj.username
        countryObj = Country(phoneCode: userObj.mobileCode.replacingOccurrences(of: "+", with: ""), isoCode: "VN")
    }
    
    init() {
        setData()
    }
    
    func serviceCallUpdate(){
        if txtName.isEmpty {
            self.errorMessage = "Please enter name"
            self.showError = true
            return
        }
        
        if txtMobile.isEmpty {
            self.errorMessage = "Please enter mobile phone number"
            self.showError = true
            return
        }
        if txtMobileCode.isEmpty {
            self.errorMessage = "Please enter mobile code"
            self.showError = true
            return
        }
        if txtUserName.isEmpty {
            self.errorMessage = "Please enter username"
            self.showError = true
            return
        }
        
        
        ServiceCall.post(
            parameter: ["username":txtUserName,
                        "name": txtName,
                        "mobile" : txtMobile,
                        "mobile_code" : txtMobileCode],
            path: Globs.SV_UPDATE_PROFILE, isToken: true) { responseObj in
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        MainViewModel.shared.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                        
                        self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                        self.showError = true
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
    
    
    func serviceCallChangePassword(){
        
        if txtCurrentPassword.isEmpty {
            self.errorMessage = "Please enter current password"
            self.showError = true
            return
        }
        
        if txtNewPassword.count < 6 {
            self.errorMessage = "Please enter new password minium 6 character"
            self.showError = true
            return
        }
        
        if txtNewPassword != txtConfirmPassword {
            self.errorMessage = "Password not match"
            self.showError = true
            return
        }
        
        ServiceCall.post(
            parameter: ["current_password":txtCurrentPassword,
                        "new_password": txtNewPassword
                       ],
            path: Globs.SV_CHANGE_PASSWORD, isToken: true) { responseObj in
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        self.txtCurrentPassword = ""
                        self.txtNewPassword = ""
                        self.txtConfirmPassword = ""
                        self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Success"
                        self.showError = true
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
