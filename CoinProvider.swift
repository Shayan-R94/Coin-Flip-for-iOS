//
//  CoinProvider.swift
//  CoinFlip
//
//  Created by Shayan Rastegar on 06/03/2017.
//  Copyright © 2017 Shayan Rastegar. All rights reserved.
//

import GameKit

struct CoinSideProvider {

var coinSides: [UIImage] = [
    UIImage(named: "coinHeads.png")!,
    UIImage(named: "coinTails.png")!
]

func randomCoinSide() -> UIImage {
    let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: coinSides.count)
    return coinSides[randomNumber]
    }
}


