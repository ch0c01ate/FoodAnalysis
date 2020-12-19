//
//  MealPageViewController.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import UIKit

class MealPageViewController: UIViewController, Storyboarded {
    @IBOutlet weak var appBarView: UIView!
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var mealTextView: UITextView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    @IBAction func deleteMeal(_ sender: UIButton) {
        if let id = meal?.id {
            self.coordinator?.mealManager?.deleteMeal(with: id)
            self.coordinator?.home()
        }
    }

    weak var coordinator: MainCoordinator?
    var meal: Meal?
    var nutrition: Nutrition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        self.showSpinner(onView: view)
        NetworkManager.parse(text: meal?.text ?? "") { (result) in
            self.removeSpinner()
            switch result {
            case .success(let nutrition):
                self.nutrition = nutrition
                self.mealTextView.text = self.parseMealText()
            case .failure(let issue):
                self.showAlert(title: AppStrings.error, msg: issue.localizedDescription)
            }
            
        }
    }
    
    func setup() {
        appBarView.backgroundColor = AppColors.lavenderBlue
        deleteBtn.backgroundColor = AppColors.redCrayola
        deleteBtn.tintColor = UIColor.white
        deleteBtn.layer.cornerRadius = 12
    }
    

    func parseMealText() -> String {
        guard let result = nutrition else { return AppStrings.error }
        
        guard let ingredients = result.ingredients?.first?.parsed else { return AppStrings.error }
        
        var text: String = "Ingredients:\n\n"
        
        for ingredient in ingredients {
            text.append("\(ingredient.food!.capitalized) with weight of \(ingredient.weight!)g;\n")
        }
        
        text.append("\nHealth tags: ")
        
        for tag in result.healthLabels ?? [] {
            text.append("#\(tag), ")
        }
        
        text.append("so on...\n")
        
        text.append("\nTotal calories: \(result.calories ?? 0)")
        
        text.append("\nProtein calories: \(result.totalNutrients?.protein?.quantity ?? 0)")
        text.append("\nFats calories: \(result.totalNutrients?.fats?.quantity ?? 0)")
        text.append("\nCarbohydrates calories: \(result.totalNutrients?.carbohydrates?.quantity ?? 0)")
        return text
    }

}
