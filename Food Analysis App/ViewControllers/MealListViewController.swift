//
//  MealListViewController.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import UIKit

class MealListViewController: UIViewController, Storyboarded {
    @IBOutlet weak var appBarView: UIView!
    @IBOutlet weak var appBarTitle: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    
    @IBAction func addMeal(_ sender: UIButton) {
        coordinator?.addMeal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyles()

    }
    
    func setupStyles() {
        view.backgroundColor = AppColors.grey
        navigationController?.setStatusBar(backgroundColor: AppColors.lavenderBlue)
        appBarView.backgroundColor = AppColors.lavenderBlue
        appBarTitle.textColor = AppColors.royalBlue
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        tableView.backgroundColor = AppColors.grey
        
        setupTableView()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let imageNib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(imageNib, forCellReuseIdentifier: "MealTableViewCell")
        
        let imageNib2 = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        tableView.register(imageNib2, forCellReuseIdentifier: "HeaderTableViewCell")
    }
}

extension MealListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppConstants.tableRowHeight
    }
}

extension MealListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.coordinator?.mealManager?.meals.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let meal = self.coordinator?.mealManager?.getSortedMeals()[indexPath.row] else { fatalError() }
        self.coordinator?.showMeal(meal: meal)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as? HeaderTableViewCell else {
                fatalError()
            }
            
            cell.setupText(text: "Total kkal: \(self.coordinator?.mealManager?.getTotalCalories() ?? 0.0)")
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as? MealTableViewCell else {
            fatalError()
        }
        
        guard let meal = self.coordinator?.mealManager?.getSortedMeals()[indexPath.row - 1] else { fatalError() }
        
        cell.configure(meal: meal)
        return cell
    }
    
}
