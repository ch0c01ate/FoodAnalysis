//
//  MealManager.swift
//  Food Analysis App
//
//  Created by Viacheslav Bernadzikovskyi on 19.12.2020.
//

import Foundation
import CoreData

class MealManager {
    private(set) var meals: [Meal] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodAnalysis")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    init() {
        prepareForUse()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        print("Saved context")
    }
    
    var searchQuery: String?
    
    func getSortedMeals() -> Array<Meal> {
        return meals.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
    }
    
    func getTotalCalories() -> Double {
        var sum = 0.0
        for meal in meals {
            sum += meal.energy
        }
        
        return sum
    }
    
    func createMeal(with text:String, date: Date, energy: Double, fats:Double, carbohydrates:Double, protein:Double) {
        let meal = Meal(with:text, date: date, energy: energy, fats:fats, carbohydrates:carbohydrates, protein:protein)
        meals.append(meal)
        let entity = NSEntityDescription.entity(forEntityName: AppStrings.entityName, in: persistentContainer.viewContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
        managedObject.setValue(meal.id, forKey: "id")
        managedObject.setValue(text, forKey: "text")
        managedObject.setValue(date, forKey: "date")
        managedObject.setValue(energy, forKey: "energy")
        managedObject.setValue(fats, forKey: "fats")
        managedObject.setValue(fats, forKey: "carbohydrates")
        managedObject.setValue(fats, forKey: "protein")



        saveContext()
        do {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: AppStrings.entityName)
        let results = try persistentContainer.viewContext.fetch(fetchRequest)
        print(results)
        } catch {

        }
    }
    
    func getMeal(with id:Int) -> Meal? {
        return meals.first(where: { $0.id == id })
    }
    
    func deleteMeal(with id: Int) {
        if let index = meals.firstIndex(where: {$0.id == id}) {
            meals.remove(at: index)
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: AppStrings.entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [Int32(id)])
            
            do {
                let result = try persistentContainer.viewContext.fetch(fetchRequest)
                if (result.count == 1) {
                    let managedObject = result.first!
                    persistentContainer.viewContext.delete(managedObject)
                    saveContext()
                }
            } catch let nserror as NSError {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
        }
    }
    
    private func prepareForUse(){
        var maxId = 0;
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: AppStrings.entityName)
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            print(results)
            for (note) in results {
                guard let id = note.value(forKeyPath: "id") as? Int else {
                    continue
                }
                
                guard let text = note.value(forKeyPath: "text") as? String else {
                    continue
                }
                
                guard let date = note.value(forKeyPath: "date") as? Date else {
                    continue
                }
                
                guard let energy = note.value(forKeyPath: "energy") as? Double else {
                    continue
                }
                
                guard let protein = note.value(forKeyPath: "protein") as? Double else {
                    continue
                }
                
                guard let fats = note.value(forKeyPath: "fats") as? Double else {
                    continue
                }
                
                guard let carbohydrates = note.value(forKeyPath: "carbohydrates") as? Double else {
                    continue
                }
                
                print("fetched item")
                
                maxId = max(maxId, id)
                
                let meal = Meal(with: text, date: date, energy: energy, fats:fats, carbohydrates:carbohydrates, protein:protein, id: id)
                
                meals.append(meal)
                
            }
            Meal.idFactory = maxId
        } catch let nserror as NSError {
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        print("fetched")
        print(meals)
    }
}
