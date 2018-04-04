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
    var cards = [Card]()
    var prevSeen = [Int : Int]()
    
    // Created an optional computed property
    var indexOfOneAndOnlyFaceUpCard: Int? {
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
        var scoreIncreased = false
        
        if prevSeen[index] == nil {
            prevSeen[index] = 1
        }
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                // Check if cards match
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    scoreIncreased = true
                }
                cards[index].isFaceUp = true
            }
            else {
                // Either no cards or two cards are face ups
                indexOfOneAndOnlyFaceUpCard = index
            }
            if prevSeen[index] == 2, !scoreIncreased {
                score -= 1
            }
            else {
                prevSeen[index] = 2
                scoreIncreased = false
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int) {
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
