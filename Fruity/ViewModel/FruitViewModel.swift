//
//  FruitViewModel.swift
//  Fruity
//
//  Created by Frédéric Helfer on 20/10/22.
//

import Foundation
import CoreData
import SwiftUI

class FruitViewModel: ObservableObject {
    let container: NSPersistentContainer
    let moc: NSManagedObjectContext
    
    @Published var fruits: [FruitModel] = []
    @Published var fetchedFruits: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruityDataBase")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        moc = container.viewContext
        
        fetchFruitFromCoreData()
        getData()
    }
    
    func fetchFruitFromCoreData() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")

        do {
            fetchedFruits = try moc.fetch(request)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateCache() {
        for fruit in fruits {
            let cachedFruit = FruitEntity(context: moc)
            cachedFruit.id = Int16(fruit.id)
            cachedFruit.name = fruit.name
            cachedFruit.family = fruit.family
            cachedFruit.genus = fruit.genus
            cachedFruit.order = fruit.order

            let cachedNutrition = NutritionEntity(context: moc)
            cachedNutrition.carbohydrates = fruit.nutritions.carbohydrates
            cachedNutrition.protein = fruit.nutritions.protein
            cachedNutrition.fat = fruit.nutritions.fat
            cachedNutrition.calories = Int16(fruit.nutritions.calories)
            cachedNutrition.sugar = fruit.nutritions.sugar
            cachedFruit.nutritions = cachedNutrition
        }
        
        save()
    }
    
    func getData() {
        guard fruits.isEmpty else { return }

        let url = URL(string: "https://www.fruityvice.com/api/fruit/all")!
        
        downloadData(fromURL: url) { data in
            guard let data = data else { return }
            
            guard let decoded = try? JSONDecoder().decode([FruitModel].self, from: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.fruits = decoded
                self?.updateCache()
                self?.fetchFruitFromCoreData()
            }
        }
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let httpResponse = response as? HTTPURLResponse,
//                response.statusCode >= 200 && response.statusCode < 300
                    (200...299).contains(httpResponse.statusCode)
            else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }
        .resume()
    }
    
    func save() {
        guard moc.hasChanges else { return }
        
        do {
            try moc.save()
        } catch let error {
            print("Error saving. \(error.localizedDescription)")
        }
    }
}
