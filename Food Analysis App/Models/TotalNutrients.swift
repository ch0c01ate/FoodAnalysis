//
//  TotalNutrients.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import Foundation

struct TotalNutrients: Codable {
    var energy: Nutrient?
    var protein: Nutrient?
    var fats: Nutrient?
    var carbohydrates: Nutrient?
    
    enum CodingKeys: String, CodingKey {
        case energy = "ENERC_KCAL"
        case protein = "PROCNT_KCAL"
        case fats = "FAT_KCAL"
        case carbohydrates = "CHOCDF_KCAL"
    }
    
}

extension TotalNutrients {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.energy = try container.decode(Nutrient.self, forKey: .energy)
        self.protein = try container.decode(Nutrient.self, forKey: .protein)
        self.fats = try container.decode(Nutrient.self, forKey: .fats)
        self.carbohydrates = try container.decode(Nutrient.self, forKey: .carbohydrates)
    }
}

struct Nutrient: Codable {
    var label: String?
    var quantity: Int?
    var unit: String?
    
    enum CodingKeys: String, CodingKey {
        case label
        case quantity
        case unit
    }
    
}

extension Nutrient {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decode(String.self, forKey: .label)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.unit = try container.decode(String.self, forKey: .unit)
    }
}
