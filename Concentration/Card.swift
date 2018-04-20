//
//  Card.swift
//  Concentration
//
//  Created by Bijan Fazeli on 3/21/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import Foundation

// Structs are value types
// Passing structs around isn't inefficient b/c it only copies on write
//    i.e. When someone modifies it.
struct Card {
    var isFaceUp = false
    var isMatched = false
    var seen = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        // No need for 'Card.' b/c already in a static method can access
        // all other static variables and method
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

