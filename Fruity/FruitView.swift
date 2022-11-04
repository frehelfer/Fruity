//
//  FruitView.swift
//  Fruity
//
//  Created by Frédéric Helfer on 04/11/22.
//

import SwiftUI

struct FruitView: View {
    var fruit: FruitEntity
    
    var body: some View {
        List {
            Section("Info") {
                Text("Family: \(fruit.wrappedFamily)")
                Text("Order: \(fruit.wrappedOrder)")
                Text("Genus: \(fruit.wrappedGenus)")
            }
            
            Section("Nutritional values") {
                Text("Calories: \(fruit.nutritions?.calories ?? 0)")
                Text("Carbohydrates: " + String(format: "%0.2f", fruit.nutritions?.carbohydrates ?? 0))
                Text("Sugar: " + String(format: "%0.2f", fruit.nutritions?.sugar ?? 0))
                Text("Fat: " + String(format: "%0.2f", fruit.nutritions?.fat ?? 0))
                Text("Protein: " + String(format: "%0.2f", fruit.nutritions?.protein ?? 0))
            }
        }
        .navigationTitle(fruit.wrappedName)
    }
}

//struct FruitView_Previews: PreviewProvider {
//    static var previews: some View {
//        FruitView(fruit: FruitModel.example)
//    }
//}
