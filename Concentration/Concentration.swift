//
//  Concentration.swift
//  Concentration
//
//  Created by Bijan Fazeli on 3/21/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import Foundation

// Classes are reference type
class Concentration {
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the Cards
    }
}
