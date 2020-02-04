//
//  buttonAnimationExtension.swift
//  CoinFlip
//
//  Created by Shayan Rastegar on 12/05/2019.
//  Copyright © 2019 Shayan Rastegar. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.7
        pulse.fromValue = 0.94
        pulse.toValue = 1
        pulse.autoreverses = false
        pulse.repeatCount = 0
        pulse.initialVelocity = 5
        pulse.damping = 0.4
        
        layer.add(pulse, forKey: "pulse")
    }
}
