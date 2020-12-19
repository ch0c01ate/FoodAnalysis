//
//  MealEntity.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import Foundation

struct Meal: Hashable {
    var text: String
    var date: Date
    var energy: Double
    var fats: Double
    var carbohydrates: Double
    var protein: Double
    
    private(set) var id: Int
    
    static var idFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        idFactory += 1
        return Meal.idFactory
    }

    init(with text:String, date: Date, energy: Double, fats:Double, carbohydrates:Double, protein:Double, id:Int = getUniqueIdentifier()) {
        self.id = id
        self.text = text
        self.date = date
        self.energy = energy
        self.fats = fats
        self.protein = protein
        self.carbohydrates = carbohydrates
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
