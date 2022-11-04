//
//  FruitView.swift
//  Fruity
//
//  Created by Frédéric Helfer on 04/11/22.
//

import SwiftUI

struct FruitView: View {
    var fruit: FruitModel
    
    var body: some View {
        List {
            Section("Info") {
                Text("Family: \(fruit.family)")
                Text("Order: \(fruit.order)")
                Text("Genus: \(fruit.genus)")
            }
            
            Section("Nutritional values") {
                Text("Calories: \(fruit.nutritions.calories)")
                Text("Carbohydrates: " + String(format: "%0.2f", fruit.nutritions.carbohydrates))
                Text("Sugar: " + String(format: "%0.2f", fruit.nutritions.sugar))
                Text("Fat: " + String(format: "%0.2f", fruit.nutritions.fat))
                Text("Protein: " + String(format: "%0.2f", fruit.nutritions.protein))
            }
        }
        .navigationTitle(fruit.name)
    }
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        FruitView(fruit: FruitModel.example)
    }
}
