//
//  ForgotPasswordViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    static var shared: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var txtEmail: String = ""

    @Published var txtNewPassword: String = ""
    @Published var txtRequestCode: String = ""
    @Published var txtConfirmPassword: String = ""
    
    @Published var showVerify: Bool = false
    @Published var showSetPassword: Bool = false
  
    @Published var isNewPassword: Bool = false
    @Published var isConfirmPassword: Bool = false
    
    var resetObj: NSDictionary?
    
    
    func clearAll(){
        txtNewPassword = ""
        txtConfirmPassword = ""
        isNewPassword = false
        isConfirmPassword = false
    }
    
    init() {
     
    }
    
    func serviceCallRequest(){
        if !txtEmail.isValidEmail {
            self.errorMessage = "Please enter valid email address"
            self.showError = true
            return
        }
        
      
        
        
        ServiceCall.post(
            parameter: ["email":txtEmail],
            path: Globs.SV_FORGOT_PASSWORD_REQUEST, isToken: false) { responseObj in
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        self.showVerify = true
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
    
    func serviceCallVerify(){
        if txtRequestCode.count != 4 {
            self.errorMessage = "Please enter valid OTP"
            self.showError = true
            return
        }
        ServiceCall.post(
            parameter: ["email":txtEmail, "request_code": txtRequestCode],
            path: Globs.SV_FORGOT_PASSWORD_VERIFY, isToken: false) { responseObj in
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        self.resetObj = response.value(forKey: KKey.payload) as? NSDictionary
                        self.showVerify = false
                        self.showSetPassword = true
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
    
    
    func serviceCallSet(){
        
        
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
            parameter: ["user_id": self.resetObj?.value(forKey: "user_id") ?? "",
                        "request_code" : self.resetObj?.value(forKey: "reset_code") ?? "",
                        "new_password": txtNewPassword
                       ],
            path: Globs.SV_FORGOT_PASSWORD_SET_PASSWORD, isToken: true) { responseObj in
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        self.txtEmail = ""
                        self.txtNewPassword = ""
                        self.txtConfirmPassword = ""
                        self.showVerify = false
                        self.showSetPassword = false
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
