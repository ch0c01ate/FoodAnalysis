//
//  Coordinator.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 08.11.2020.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var mealManager: MealManager?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.mealManager = MealManager()
    }
    
    func start() {
        home()
    }
    

    func home(animated: Bool = false) {
        let vc = MealListViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func addMeal() {
        let vc = AddFoodsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func saveMeal(nutrition: Nutrition, date: Date) {
        let vc = SaveFoodsViewController.instantiate()
        vc.coordinator = self
        vc.date = date
        vc.nutrition = nutrition
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMeal(meal: Meal) {
        let vc = MealPageViewController.instantiate()
        vc.coordinator = self
        vc.meal = meal
        navigationController.pushViewController(vc, animated: true)
    }
    
//    func createNote(manager: NoteDataManager) {
//        let vc = CreateNoteViewController.instantiate()
//        vc.coordinator = self
//        vc.notesManager = manager
//        navigationController.pushViewController(vc, animated: true)
//    }
//
//    func editNote(manager: NoteDataManager, itemId: Int) {
//        let vc = EditNoteViewController.instantiate()
//        vc.coordinator = self
//        vc.notesManager = manager
//        vc.itemId = itemId
//        navigationController.pushViewController(vc, animated: true)
//    }
}
