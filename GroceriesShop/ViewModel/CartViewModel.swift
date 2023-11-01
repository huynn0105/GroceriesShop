//
//  CartViewModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 24/10/2023.
//

import Foundation

class CartViewModel: ObservableObject {
    static var shared: CartViewModel = CartViewModel()
    @Published var showError = false
    @Published var showOrderAccepted = false
    @Published var errorMessage = ""
    @Published var listArr: [CartItemModel] = []
    @Published var total: String = "0.0"
    @Published var showCheckout: Bool = false
    @Published var showPickerAddress: Bool = false
    @Published var showPickerPayment: Bool = false
    @Published var showPickerPromoCode: Bool = false
    
    @Published var deliveryType: Int = 1
    @Published var paymentType: Int = 1
    @Published var deliveryObj: AddressModel?
    @Published var paymentObj: PaymentModel?
    @Published var promoCodeObj: PromoCodeModel?
    
    @Published var deliverPriceAmount: String = ""
    @Published var discountPriceAmount: String = ""
    @Published var userPayAmount: String = ""
    
    init() {
        serviceCallList()
    }
    
    func serviceCallList(){
        ServiceCall.post(parameter: ["promo_code_id": promoCodeObj?.promoCodeId ?? "", "delivery_type": deliveryType], path: Globs.SV_CART_LIST, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.total = response.value(forKey: KKey.total) as? String ?? "0.0"
                    self.discountPriceAmount = response.value(forKey: "discount_amount") as? String ?? "0.0"
                    self.deliverPriceAmount = response.value(forKey: "deliver_price_amount") as? String ?? "0.0"
                    self.userPayAmount = response.value(forKey: "user_pay_price") as? String ?? "0.0"
                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
                        return CartItemModel(dict: obj as? NSDictionary ?? [:])
                    })
                }
                else {
                    self.total = response.value(forKey: KKey.total) as? String ?? "0.0"
                    self.discountPriceAmount = response.value(forKey: "discount_amount") as? String ?? "0.0"
                    self.deliverPriceAmount = response.value(forKey: "deliver_price_amount") as? String ?? "0.0"
                    self.userPayAmount = response.value(forKey: "user_pay_price") as? String ?? "0.0"
                    self.promoCodeObj = nil
                    self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? "Fail"
            self.showError = true
        }

    }
    
    func serviceCallUpdateCart(cObj: CartItemModel, newQty: Int){
        ServiceCall.post(parameter: ["cart_id": cObj.cartId, "prod_id": cObj.productId, "new_qty": newQty], path: Globs.SV_UPDATE_CART, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                  
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
    
    func serviceCallRemoveCart(cObj: CartItemModel){
        ServiceCall.post(parameter: ["cart_id": cObj.cartId, "prod_id": cObj.productId], path: Globs.SV_REMOVE_CART, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                
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
    
    func serviceCallOrderPlace(){
        if deliveryType == 1 && deliveryObj == nil {
            self.errorMessage = "Please select delivery address"
            self.showError = true
            return
        }
        
        if paymentType == 2 && paymentObj == nil {
            self.errorMessage = "Please select payment method"
            self.showError = true
            return
        }
        
        ServiceCall.post(
            parameter: ["address_id": deliveryType == 2 ? "" : "\(deliveryObj?.addressId ?? 0)",
                        "payment_type": paymentType,
                        "deliver_type": deliveryType,
                        "promo_code_id": promoCodeObj?.promoCodeId ?? "",
                        "pay_id": paymentType == 1 ? "" : "\(promoCodeObj?.promoCodeId ?? 0)",
                       ], path: Globs.SV_ORDER_PLACE, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.deliveryObj = nil
                    self.paymentObj = nil
                    self.promoCodeObj = nil
                    self.showCheckout = false
                   
                    self.serviceCallList()
                    self.showOrderAccepted = true
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
    
    
    
    class func serviceCallAddToCart(prodId: Int, qty: Int, didDone: ((_ isDone: Bool,_ message: String)->())? ) {
        ServiceCall.post(parameter: ["prod_id":prodId, "qty": qty], path: Globs.SV_ADD_TO_CART, isToken: true) { responseObj in
            if let response = responseObj as? NSDictionary {
                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                
                }
                else {
                    didDone?(false, response.value(forKey: KKey.message) as? String ?? "Fail")
                }
            }
        } failure: { error in
            didDone?(false, error?.localizedDescription ?? "Fail")
        }
    }
}
