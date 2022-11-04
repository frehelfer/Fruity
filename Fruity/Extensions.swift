//
//  Extensions.swift
//  Fruity
//
//  Created by Frédéric Helfer on 04/11/22.
//

import Foundation


extension FruitEntity {
    var wrappedName: String {
        name ?? "Unknown"
    }
    
    var wrappedOrder: String {
        order ?? ""
    }
    
    var wrappedGenus: String {
        genus ?? ""
    }
    
    var wrappedFamily: String {
        family ?? ""
    }
}
