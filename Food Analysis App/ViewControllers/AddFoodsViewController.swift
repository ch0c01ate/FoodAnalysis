//
//  AddFoodsViewController.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import UIKit

class AddFoodsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var appBarView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var appBarTitle: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addMeal(_ sender: UIButton) {
        if let text = textView.text {
            if(text.isEmpty || text == AppStrings.mealExample) {
                self.showAlert(title: AppStrings.error, msg: AppStrings.mealNotDescribed)
            } else {
                if let dateText = dateTextField.text {
                    if dateText.isEmpty {
                        self.showAlert(title: AppStrings.error, msg: AppStrings.dateNotSelected)
                    } else {
                        showSpinner(onView: view)
                        NetworkManager.parse(text: text) { (result) in
                            self.removeSpinner()
                            switch result {
                            case .success(let nutrition):
                                self.coordinator?.saveMeal(nutrition: nutrition, date: self.datePicker.date)
                            case .failure(let issue):
                                self.showAlert(title: AppStrings.error, msg: issue.localizedDescription)
                            }
                        }
                    }
                } else {
                    self.showAlert(title: AppStrings.error, msg: AppStrings.unexpectedError)
                }
            }
        }
        else {
            self.showAlert(title: AppStrings.error, msg: AppStrings.unexpectedError)
        }
    }
    
    let datePicker = UIDatePicker()
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        setupStyles()
        

    }
    
    func setupStyles() {
        view.backgroundColor = AppColors.grey
        navigationController?.setStatusBar(backgroundColor: AppColors.lavenderBlue)
        textView.layer.cornerRadius = 16
        textView.textContainerInset = UIEdgeInsets(top: 20,left: 13,bottom: 20,right: 13)
        textView.text = AppStrings.mealExample
        textView.textColor = UIColor.lightGray
        appBarView.backgroundColor = AppColors.lavenderBlue
        appBarTitle.textColor = AppColors.royalBlue
        addButton.layer.cornerRadius = 16
        addButton.backgroundColor = AppColors.redCrayola
        addButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        customizeDatePicker()
    }
    
    func customizeDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onDataSelected))
        toolbar.setItems([doneBtn], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    @objc func onDataSelected() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}

extension AddFoodsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = AppColors.royalBlue
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = AppStrings.mealExample
            textView.textColor = UIColor.lightGray
        }
    }
}
