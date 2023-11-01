//
//  MyOrderModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 26/10/2023.
//

import Foundation

struct MyOrderModel: Identifiable, Equatable{
    var id: UUID = UUID()
    var orderId: Int = 0
    var cartId: Int = 0
    var totalPrice: Double = 0.0
    var userPayPrice: Double = 0.0
    var discountPrice: Double = 0.0
    var deliverPrice: Double = 0.0
    var deliverType: Int = 0
    var paymentType: Int = 0
    var paymentStatus: Int = 0
    var orderStatus: Int = 0
    var names: String = ""
    var images: String = ""
    var userName: String = ""
    var phone: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var postalCode: String = ""
    var createdDate: Date = Date()
    
    
    init(dict: NSDictionary) {
        self.orderId = dict.value(forKey: "order_id") as? Int ?? 0
        self.cartId = dict.value(forKey: "cart_id") as? Int ?? 0
        self.totalPrice = dict.value(forKey: "total_price") as? Double ?? 0.0
        self.discountPrice = dict.value(forKey: "discount_price") as? Double ?? 0.0
        self.userPayPrice = dict.value(forKey: "user_pay_price") as? Double ?? 0.0
        self.deliverPrice = dict.value(forKey: "deliver_price") as? Double ?? 0.0
        self.deliverType = dict.value(forKey: "deliver_type") as? Int ?? 0
        self.paymentType = dict.value(forKey: "payment_type") as? Int ?? 0
        self.paymentStatus = dict.value(forKey: "payment_status") as? Int ?? 0
        self.orderStatus = dict.value(forKey: "order_status") as? Int ?? 0
        self.names = dict.value(forKey: "names") as? String ?? ""
        self.images = dict.value(forKey: "images") as? String ?? ""
        self.userName = dict.value(forKey: "user_name") as? String ?? ""
        self.phone = dict.value(forKey: "phone") as? String ?? ""
        self.address = dict.value(forKey: "address") as? String ?? ""
        self.city = dict.value(forKey: "city") as? String ?? ""
        self.state = dict.value(forKey: "state") as? String ?? ""
        self.postalCode = dict.value(forKey: "postal_code") as? String ?? ""
        self.createdDate = (dict.value(forKey: "created_date") as? String ?? "")?.stringDateToDate() ?? Date()
    }
    
    static func == (lhs: MyOrderModel, rhs: MyOrderModel) -> Bool {
        return lhs.id == rhs.id
    }
}
