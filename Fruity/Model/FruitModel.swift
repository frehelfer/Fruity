//
//  FruitModel.swift
//  Fruity
//
//  Created by Frédéric Helfer on 20/10/22.
//

import Foundation

struct FruitModel: Identifiable, Codable {
    let id: Int
    let name: String
    let family: String
    let genus: String
    let order: String
    let nutritions: NutritionsValue
    
    struct NutritionsValue: Codable {
        let carbohydrates: Double
        let protein: Double
        let fat: Double
        let calories: Int
        let sugar: Double
    }
    
    static let example = FruitModel(id: 1, name: "Abacate", family: "abactfamily", genus: "não sei", order: "não sei", nutritions: NutritionsValue(carbohydrates: 2.0, protein: 2.0, fat: 1.0, calories: 10, sugar: 5.0))
}
