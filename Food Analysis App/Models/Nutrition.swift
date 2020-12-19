//
//  Meal.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import Foundation

struct Nutrition: Codable {
    var calories: Int?
    var totalWeight: Double?
    var dietLabels: Array<String>?
    var healthLabels: Array<String>?
    var cautions: Array<String>?
    var totalNutrients: TotalNutrients?
    var ingredients: Array<Ingredients>?
    
    enum CodingKeys: String, CodingKey {
        case calories
        case totalWeight
        case dietLabels
        case healthLabels
        case cautions
        case totalNutrients = "totalNutrientsKCal"
        case ingredients
    }
    
}

extension Nutrition {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.calories = try container.decode(Int.self, forKey: .calories)
        self.totalWeight = try container.decode(Double.self, forKey: .totalWeight)
        self.dietLabels = try container.decode(Array<String>.self, forKey: .dietLabels)
        self.healthLabels = try container.decode(Array<String>.self, forKey: .healthLabels)
        self.cautions = try container.decode(Array<String>.self, forKey: .cautions)
        self.totalNutrients = try container.decode(TotalNutrients.self, forKey: .totalNutrients)
        self.ingredients = try container.decode(Array<Ingredients>.self, forKey: .ingredients)
    }
}
