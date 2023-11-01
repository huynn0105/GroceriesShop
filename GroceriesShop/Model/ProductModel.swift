//
//  ProductModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/09/2023.
//

import Foundation

struct ProductModel: Identifiable, Equatable {
    var id: Int = 0
    var productId: Int = 0
    var cartId: Int = 0
    var brandId: Int = 0
    var typeId: Int = 0
    var detail: String = ""
    var name: String = ""
    var unitName: String = ""
    var unitValue: String = ""
    var nutritionWeight: String = ""
    var authToken: String = ""
    var image: String = ""
    var catName: String = ""
    var type: String = ""
    var price: Double = 0
    var isFav: Bool = false
    
    
    var offerPrice: Double?
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "prod_id") as? Int ?? 0
        self.productId = dict.value(forKey: "prod_id") as? Int ?? 0
        self.cartId = dict.value(forKey: "cart_id") as? Int ?? 0
        self.brandId = dict.value(forKey: "brand_id") as? Int ?? 0
        self.typeId = dict.value(forKey: "type_id") as? Int ?? 0
        self.isFav = dict.value(forKey: "is_fav") as? Int ?? 0 == 1
        self.detail = dict.value(forKey: "detail") as? String ?? ""
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.unitName = dict.value(forKey: "unit_name") as? String ?? ""
        self.unitValue = dict.value(forKey: "unit_value") as? String ?? ""
        self.nutritionWeight = dict.value(forKey: "nutrition_weight") as? String ?? ""
        self.offerPrice = dict.value(forKey: "offer_price") as? Double
        self.price = dict.value(forKey: "price") as? Double ?? 0.0
        self.authToken = dict.value(forKey: "auth_token") as? String ?? ""
        self.image = dict.value(forKey: "image") as? String ?? ""
        self.catName = dict.value(forKey: "cat_name") as? String ?? ""
        self.type = dict.value(forKey: "type") as? String ?? ""
        self.startDate = (dict.value(forKey: "start_date") as? String ?? "" ).stringDateToDate() ?? Date()
        self.endDate = (dict.value(forKey: "end_date") as? String ?? "" ).stringDateToDate() ?? Date()
    }
    
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
}
