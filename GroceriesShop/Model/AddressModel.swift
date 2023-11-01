//
//  AddressModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/10/2023.
//

import SwiftUI

struct AddressModel: Identifiable, Equatable{
    var id: UUID = UUID()
    var addressId: Int = 0
    var name: String = ""
    var phone: String = ""
    var address: String = ""
    var city: String = ""
    var state: String = ""
    var typeName: String = ""
    var postalCode: String = ""
    var isDefault: Int = 0
    var color: Color = Color.primaryApp
    
    
    init(dict: NSDictionary) {
        self.addressId = dict.value(forKey: "address_id") as? Int ?? 0
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.phone = dict.value(forKey: "phone") as? String ?? ""
        self.address = dict.value(forKey: "address") as? String ?? ""
        self.city = dict.value(forKey: "city") as? String ?? ""
        self.state = dict.value(forKey: "state") as? String ?? ""
        self.typeName = dict.value(forKey: "type_name") as? String ?? ""
        self.postalCode = dict.value(forKey: "postal_code") as? String ?? ""
        self.color = Color(hex: dict.value(forKey: "color") as? String ?? "000000")
    }
    
    static func == (lhs: AddressModel, rhs: AddressModel) -> Bool {
        return lhs.id == rhs.id
    }
}
