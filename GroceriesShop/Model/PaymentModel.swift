//
//  PaymentModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 26/10/2023.
//

import Foundation

struct PaymentModel: Identifiable, Equatable{
    var id: UUID = UUID()
    var payId: Int = 0
    var name: String = ""
    var cardNumber: String = ""
    var cardMonth: String = ""
    var cardYear: String = ""
    
    
    init(dict: NSDictionary) {
        self.payId = dict.value(forKey: "pay_id") as? Int ?? 0
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.cardNumber = dict.value(forKey: "card_number") as? String ?? ""
        self.cardMonth = dict.value(forKey: "card_month") as? String ?? ""
        self.cardYear = dict.value(forKey: "card_year") as? String ?? ""
    }
    
    static func == (lhs: PaymentModel, rhs: PaymentModel) -> Bool {
        return lhs.id == rhs.id
    }
}
