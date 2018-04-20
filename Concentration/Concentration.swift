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
    var score = 0
    private(set) var cards = [Card]()
    private var prevSeen = [Int : Int]()
    
    // Created an optional computed property
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func newGame() {
        self.score = 0
        self.prevSeen = [Int : Int]()
        self.indexOfOneAndOnlyFaceUpCard = nil
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): chosen index not in the cards")
        
        
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                // Check if cards match
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else if (cards[index].seen) {
                    score -= 1
                }
                cards[index].isFaceUp = true
            }
            else {
                // Either no cards or two cards are face ups
                indexOfOneAndOnlyFaceUpCard = index
                if (cards[index].seen) {
                    score -= 1
                }
            }
            
            cards[index].seen = true;
        }
    }
    
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): You must pass at least one pair of cards.")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the Cards
        for num in cards.indices {
            let tempNum = cards[num]
            let randNum = Int(arc4random_uniform(UInt32(num)))
            cards[num] = cards[randNum]
            cards[randNum] = tempNum
        }
        
    }
}
