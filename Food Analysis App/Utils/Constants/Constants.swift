//
//  Constants.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import Foundation
import UIKit

struct AppColors {
    static let grey: UIColor = UIColor(hex: 0xF5F5F7)
    static let lavenderBlue: UIColor = UIColor(hex: 0xDFD9FF)
    static let royalBlue: UIColor = UIColor(hex: 0x141851)
    static let redCrayola: UIColor = UIColor(hex: 0xE84855)
}

struct AppStrings {
    static let mealExample: String = "Example: 3 fried eggs and a chicken"
    static let error: String = "Error!"
    static let unexpectedError: String = "Unexpected error..."
    static let mealNotDescribed: String = "Please, describe your meal..."
    static let dateNotSelected: String = "Please, select date..."
    static let entityName: String = "MealEntity"
}

struct AppConstants {
    static let tableRowHeight: CGFloat = 90
}
