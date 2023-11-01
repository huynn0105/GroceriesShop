//
//  NutritionModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 23/10/2023.
//

import Foundation

struct NutritionModel: Identifiable, Equatable {
    var id: Int
    var prodId: Int
    var nutritionName: String
    var nutritionValue: String
    
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "nutrition_id") as? Int ?? 0
        self.prodId = dict.value(forKey: "prod_id") as? Int ?? 0
        self.nutritionName = dict.value(forKey: "nutrition_name") as? String ?? ""
        self.nutritionValue = dict.value(forKey: "nutrition_value") as? String ?? ""
    }
    
    static func == (lhs: NutritionModel, rhs: NutritionModel) -> Bool {
        return lhs.id == rhs.id
    }
}
