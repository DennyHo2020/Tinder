//
//  CardsViewController.swift
//  Tinder
//
//  Created by Denny Ho on 10/29/18.
//  Copyright © 2018 Denny Ho. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    var cardInitialCenter: CGPoint!
    var whereStartedY: CGFloat!
    var whereStartedX: CGFloat!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTheImage()
        cardInitialCenter = cardImage.center

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func roundTheImage(){
        cardImage.layer.cornerRadius = 50
        cardImage.clipsToBounds = true
    }
    
    @IBAction func didPanCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if (sender.state == .began) {
            whereStartedY = sender.location(in: cardImage).y
            whereStartedX = sender.location(in: cardImage).x
        }
        else if (sender.state == .changed) {
            //Bottom Half
            if (whereStartedY > 200) {
                if (translation.x < 0) {
                    let translationAmount = max(-180, translation.x)
                    let rotationAmount = min(45,-Double(translation.x)/4) * Double.pi / 180
                    cardImage.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                    cardImage.transform = cardImage.transform.rotated(by: CGFloat(rotationAmount))
                }
                else {
                    let translationAmount = min(180, translation.x)
                    let rotationAmount = max(-45,Double(translation.x)/4) * Double.pi / 180
                    cardImage.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                    cardImage.transform = cardImage.transform.rotated(by: CGFloat(rotationAmount))
                }
            }
            //Top Half
            else {
                //Moving Left
                if (translation.x < 0) {
                    let translationAmount = max(-180, translation.x)
                    let rotationAmount = max(-45,Double(translation.x)/4) * Double.pi / 180
                    cardImage.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                    cardImage.transform = cardImage.transform.rotated(by: CGFloat(rotationAmount))
                }
                //Moving Right
                else {
                    let translationAmount = min(180, translation.x)
                    let rotationAmount = min(45,Double(translation.x)/4) * Double.pi / 180
                    cardImage.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                    cardImage.transform = cardImage.transform.rotated(by: CGFloat(rotationAmount))
                }
            }

            
        }
        else if (sender.state == .ended) {
            if (whereStartedX > 175 && translation.x > 50) {
                //on right side & translation > 50
                //animate off to left
                
            }
                
            else if (whereStartedX < 175 && translation.x < -50) { //on left side & translation < -50
                //animate off to left
                
            }
            else {
                cardImage.transform = CGAffineTransform.identity
            }
        }
    }
    
    

}
