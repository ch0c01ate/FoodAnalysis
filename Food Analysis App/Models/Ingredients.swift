//
//  Ingridients.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import Foundation

struct Ingredients: Codable {
    var parsed: Array<Ingredient>?
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case parsed
        case text
    }
    
}

extension Ingredients {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.parsed = try container.decode(Array<Ingredient>.self, forKey: .parsed)
        self.text = try container.decode(String.self, forKey: .text)
    }
}

struct Ingredient: Codable {
    var measure: String?
    var quantity: Double?
    var weight: Double?
    var food: String?
    
    enum CodingKeys: String, CodingKey {
        case measure
        case quantity
        case weight
        case food
    }
    
}

extension Ingredient {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.measure = try container.decode(String.self, forKey: .measure)
        self.quantity = try container.decode(Double.self, forKey: .quantity)
        self.weight = try container.decode(Double.self, forKey: .weight)
        self.food = try container.decode(String.self, forKey: .food)
    }
}
