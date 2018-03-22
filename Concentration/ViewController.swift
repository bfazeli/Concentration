//
//  ViewController.swift
//  Concentration
//
//  Created by Bijan Fazeli on 2/15/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
    
    var flipCount = 0 {
        // Property Observer
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton)
    {
        print("flipCard(withEmoji: \(emoji))")
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.382050842, blue: 0.1238422468, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

















