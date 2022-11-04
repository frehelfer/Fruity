//
//  FruitViewModel.swift
//  Fruity
//
//  Created by Frédéric Helfer on 20/10/22.
//

import Foundation
import SwiftUI

class FruitViewModel: ObservableObject {
    @Published var fruits: [FruitModel] = []
    
    init() {
        getData()
    }
    
    func getData() {
        let url = URL(string: "https://www.fruityvice.com/api/fruit/all")!
        
        downloadData(fromURL: url) { data in
            guard let data = data else { return }
            
            guard let decoded = try? JSONDecoder().decode([FruitModel].self, from: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.fruits = decoded
            }
        }
    }
    
func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
    //                (200...299).contains(response.statusCode)
            else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }
        .resume()
    }
}
