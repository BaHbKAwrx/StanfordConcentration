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
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var buttonsArr: [UIButton]!
    
    // MARK: - properties
    lazy var game = Concentration(numberOfCardPairs: (self.buttonsArr.count + 1) / 2)
    var emojiArr = [String]()
    var emojiDict = [Int:String]()
    var cardBackColor = UIColor()
    
    // MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emojiArr = game.gameTheme.themeEmojies
        changeBgAndCardsColor(withTheme: game.gameTheme)
        updateViewFromModel()
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
        changeBgAndCardsColor(withTheme: game.gameTheme)
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardBackColor
            }
        }
        flipCountLabel.textColor = cardBackColor
        scoreLabel.textColor = cardBackColor
        newGameButton.setTitleColor(cardBackColor, for: .normal)
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.gameScore)"
    }
    
    //setting emoji for flipped card
    func emoji(for card: Card) -> String {
        if emojiDict[card.identifier] == nil, emojiArr.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiArr.count)))
            emojiDict[card.identifier] = emojiArr.remove(at: randomIndex)
        }
        return emojiDict[card.identifier] ?? "?"
    }
    
    func changeBgAndCardsColor(withTheme theme: Theme) {
        
        switch theme.themeName {
        case "Animals":
            view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        case "Halloween":
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cardBackColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        case "Faces":
            view.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case "Food":
            view.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
            cardBackColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        case "Sports":
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            cardBackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case "Vehicles":
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cardBackColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        default:
            view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            cardBackColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        
    }
    
}

