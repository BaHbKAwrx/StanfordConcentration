//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Shmygovskii Ivan on 4/4/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - outlets
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var buttonsArr: [UIButton]!
    
    // MARK: - properties
    lazy var game = Concentration(numberOfCardPairs: (self.buttonsArr.count + 1) / 2)
    var emojiArr = [String]()
    var emojiDict = [Int:String]()
    
    // MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emojiArr = game.gameTheme.themeEmojies
    }

    // MARK: - buttonActions
    @IBAction func cardTouched(_ sender: UIButton) {
        if let cardNumber = buttonsArr.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card isnt in buttonsArray")
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = Concentration(numberOfCardPairs: (self.buttonsArr.count + 1) / 2)
        emojiArr = game.gameTheme.themeEmojies
        updateViewFromModel()
    }
    
    // MARK: - methods
    
    //synchronising modelData with our interface
    func updateViewFromModel() {
        for index in buttonsArr.indices {
            let button = buttonsArr[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    //setting emoji for flipped card
    func emoji(for card: Card) -> String {
        if emojiDict[card.identifier] == nil, emojiArr.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiArr.count)))
            emojiDict[card.identifier] = emojiArr.remove(at: randomIndex)
        }
        return emojiDict[card.identifier] ?? "?"
    }
    

}

