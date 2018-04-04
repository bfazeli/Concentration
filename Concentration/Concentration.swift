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
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func newGame() {
        self.score = 0
        self.prevSeen = [Int : Int]()
        self.indexOfOneAndOnlyFaceUpCard = nil
    }
    
    func chooseCard(at index: Int) {
        var scoreIncreased = false
        var newSet = false
        
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
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                // Either no cards or two cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
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
