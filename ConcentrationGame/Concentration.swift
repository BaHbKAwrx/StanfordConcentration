//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Shmygovskii Ivan on 4/4/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

class Concentration {
    
    static var avaliableThemes = [Theme(themeEmojies: ["🐶","🐱","🐭","🐰","🦊","🐮","🦁","🐯","🐨","🐼","🐻","🐷"]),Theme(themeEmojies: ["😈","👹","👻","💀","🎃","👽","🤡","🍭","☠️","🧠"]),Theme(themeEmojies: ["😃","😂","😜","🥳","😍","😇","😡","🥶","😵","🤢"]),Theme(themeEmojies: ["🍏","🍐","🍊","🍋","🍌","🍑","🍒","🍓","🍇","🍉"]),Theme(themeEmojies: ["⚽️","🏀","🏈","⚾️","🎾","🎱","🥏","🏉","🏐","🏓"]),Theme(themeEmojies: ["🚗","🚕","🚙","🚌","🏎","🚓","🚑","🚒","🚛","🏍"])]
    
    var cards = [Card]()
    var indexOfTheOnlyOneFacedUpCard: Int?
    var gameTheme: Theme
    
    init(numberOfCardPairs: Int) {
        
        let randomThemeIndex = Int(arc4random())%(Concentration.avaliableThemes.count)
        self.gameTheme = Concentration.avaliableThemes[randomThemeIndex]
        
        for _ in 1...numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfTheOnlyOneFacedUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfTheOnlyOneFacedUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfTheOnlyOneFacedUpCard = index
            }
        }
    }
    
}
