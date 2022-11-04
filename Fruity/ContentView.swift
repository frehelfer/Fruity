//
//  ContentView.swift
//  Fruity
//
//  Created by Frédéric Helfer on 20/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = FruitViewModel()
    
    var body: some View {
        NavigationView {
            List(vm.fruits) { fruit in
                NavigationLink {
                    FruitView(fruit: fruit)
                } label: {
                    Text(fruit.name)
                }
            }
            .navigationTitle("Fruity")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
