//
//  ViewController.swift
//  CoinFlip
//
//  Created by Shayan Rastegar on 06/03/2017.
//  Copyright © 2017 Shayan Rastegar. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ViewController: UIViewController, CAAnimationDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var flipCoinButton: UIButton!
    @IBOutlet weak var coinImageView: UIImageView!
    
    let coinProvider = CoinSideProvider()
    
    let colourProvider = BackgroundColourProvider()
    
    var flipButtonSound = URL(fileURLWithPath: Bundle.main.path(forResource: "switchSound", ofType: "mp3")!)
    
    var coinImageSound = URL(fileURLWithPath: Bundle.main.path(forResource: "tapSound", ofType: "mp3")!)
    
    var audioPlayerButton = AVAudioPlayer()
    
    var audioPlayerImage = AVAudioPlayer()
    
    var previousColour: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let randomColour = colourProvider.randomColour()
        view.backgroundColor = randomColour
        flipCoinButton.tintColor = randomColour
        
        coinImageView.image = #imageLiteral(resourceName: "coinSide")
        flipCoinButton.layer.cornerRadius = 20
        
        audioPlayerButton = try! AVAudioPlayer(contentsOf: flipButtonSound)
        audioPlayerImage = try! AVAudioPlayer(contentsOf: coinImageSound)
        
        // Setting the tap gesture to the coinImageView.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        coinImageView.isUserInteractionEnabled = true
        coinImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showCoinFlip(_ sender: UIButton) {
        sender.pulsate()
        
        flipCoinButton.isEnabled = false
        
        audioPlayerButton.play()
        
        // Setting the random colour and making sure the previous colour is not repeated consecutively.
        var randomColour = colourProvider.randomColour()
        while previousColour == randomColour {
            randomColour = colourProvider.randomColour()
        }
        previousColour = randomColour
        
        view.backgroundColor = randomColour
        flipCoinButton.tintColor = randomColour
        
        coinImageView.image = #imageLiteral(resourceName: "coinSide")
        
        audioPlayerButton.delegate = self
        
        func rotateCoin() {
            let rotateAnimation = CABasicAnimation()
            rotateAnimation.keyPath = "transform.rotation"
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = 4 * Double.pi
            rotateAnimation.duration = 0.4
            rotateAnimation.isRemovedOnCompletion = false
            rotateAnimation.delegate = self
            
            coinImageView.layer.add(rotateAnimation,
                         forKey: nil)
        }
        
        rotateCoin()
        
        func animationDidStop(_ anim: CABasicAnimation, finished flag: Bool) {
            coinImageView.layer.removeFromSuperlayer()
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        coinImageView.image = coinProvider.randomCoinSide()
        flipCoinButton.isEnabled = true
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        audioPlayerImage.play()
        
        audioPlayerImage.delegate = self
        
        _ = tapGestureRecognizer.view as! UIImageView
        
        // This is the bounce down animation.
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
            
        // This code sets the scale of the view to 70%.
        self.coinImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: nil)
        
        // This is the bounce up animation, runs at the same time as bounce down.
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
            
        // This code sets the scale of the view to 100%.
        self.coinImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}


