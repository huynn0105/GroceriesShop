//
//  ImageModel.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 23/10/2023.
//

import Foundation

struct ImageModel : Identifiable, Equatable {
    var id: Int
    var prodId: Int
    var image: String
    
    
    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "img_id") as? Int ?? 0
        self.prodId = dict.value(forKey: "prod_id") as? Int ?? 0
        self.image = dict.value(forKey: "image") as? String ?? ""
    }
    
    static func == (lhs: ImageModel, rhs: ImageModel) -> Bool {
        return lhs.id == rhs.id
    }
}
