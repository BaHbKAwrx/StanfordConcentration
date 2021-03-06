//
//  Card.swift
//  ConcentrationGame
//
//  Created by Shmygovskii Ivan on 4/4/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
