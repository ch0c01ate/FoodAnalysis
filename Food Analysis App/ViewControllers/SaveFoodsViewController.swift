//
//  SaveFoodsViewController.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import UIKit

class SaveFoodsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var appBarTitle: UILabel!
    @IBOutlet weak var appBar: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveMeal(_ sender: UIButton) {
        guard let text = nutrition?.ingredients?.first?.text else {
            showAlert(title: AppStrings.error, msg: AppStrings.unexpectedError)
            return
        }
        
        guard let protein = nutrition?.totalNutrients?.protein?.quantity else {
            showAlert(title: AppStrings.error, msg: AppStrings.unexpectedError)
            return
        }
        
        guard let energy = nutrition?.totalNutrients?.energy?.quantity else {
            showAlert(title: AppStrings.error, msg: AppStrings.unexpectedError)
            return
        }
        
        guard let fats = nutrition?.totalNutrients?.fats?.quantity else {
            showAlert(title: AppStrings.error, msg: AppStrings.unexpectedError)
            return
        }
        
        guard let carbohydrates = nutrition?.totalNutrients?.carbohydrates?.quantity else {
            showAlert(title: AppStrings.error, msg: AppStrings.unexpectedError)
            return
        }
        
        guard let mealDate = date else {
            showAlert(title: AppStrings.error, msg: AppStrings.unexpectedError)
            return
        }
        
        
        coordinator?.mealManager?.createMeal(with: text, date: mealDate, energy: Double(energy), fats: Double(fats), carbohydrates: Double(carbohydrates), protein: Double(protein))
        coordinator?.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyles()
    }
    
    weak var coordinator: MainCoordinator?
    var nutrition: Nutrition?
    var date: Date?
    
    func setupStyles() {
        view.backgroundColor = AppColors.grey
        navigationController?.setStatusBar(backgroundColor: AppColors.lavenderBlue)
        appBar.backgroundColor = AppColors.lavenderBlue
        appBarTitle.textColor = AppColors.royalBlue
        textView.layer.cornerRadius = 16
        textView.textContainerInset = UIEdgeInsets(top: 20,left: 13,bottom: 20,right: 13)
        textView.text = parseMealText()
        textView.isEditable = false
        saveButton.layer.cornerRadius = 16
        saveButton.backgroundColor = AppColors.redCrayola
        saveButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    func parseMealText() -> String {
        guard let result = nutrition else { return AppStrings.error }
        
        guard let ingredients = result.ingredients?.first?.parsed else { return AppStrings.error }
        
        var text: String = "Ingredients:\n\n"
        
        for ingredient in ingredients {
            text.append("\(ingredient.food!.capitalized) with quantity of \(ingredient.quantity!) with weight of \(ingredient.weight!);\n")
        }
        
        text.append("\nHealth tags: ")
        
        for tag in result.healthLabels ?? [] {
            text.append("#\(tag), ")
        }
        
        text.append("so on...\n")
        
        text.append("\nTotal calories: \(result.calories ?? 0)")
        
        return text
    }
}
