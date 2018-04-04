//
//  ViewController.swift
//  Concentration
//
//  Created by Bijan Fazeli on 2/15/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // Created a read-only property for calculating the number of pairs of 
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    
    
    private(set) var flipCount = 0 {
        // Property Observer
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLbl: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func newGameBtn(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        game.newGame()
        emojiChoices = [["🦇", "😱", "🍭", "😈", "🍎", "🎃", "👻"],
                        ["🐶", "🐱", "🐭", "🦁", "🐸", "🐨", "🐼"],
                        ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏓"],
                        ["🙂", "🙃", "😉", "🤪", "🤓", "😍", "🤯"],
                        ["🥑", "🥦", "🥒", "🥥", "🌽", "🥝", "🍑"],
                        ["🍔", "🍟", "🌮", "🌯", "🍕", "🥞", "🥪"]]
        theme = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            scoreLbl.text  = "Score: \(game.score)"
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.382050842, blue: 0.1238422468, alpha: 0) : #colorLiteral(red: 1, green: 0.382050842, blue: 0.1238422468, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = [["🦇", "😱", "🍭", "😈", "🍎", "🎃", "👻"],
                        ["🐶", "🐱", "🐭", "🦁", "🐸", "🐨", "🐼"],
                        ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏓"],
                        ["🙂", "🙃", "😉", "🤪", "🤓", "😍", "🤯"],
                        ["🥑", "🥦", "🥒", "🥥", "🌽", "🥝", "🍑"],
                        ["🍔", "🍟", "🌮", "🌯", "🍕", "🥞", "🥪"]]
    
    private lazy var theme = Int(arc4random_uniform(UInt32(emojiChoices.count)))
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices[theme].count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices[theme].count)))
            emoji[card.identifier] = emojiChoices[theme].remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

















