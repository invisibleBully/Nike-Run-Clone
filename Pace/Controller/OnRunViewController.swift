//
//  OnRunViewController.swift
//  Pace
//
//  Created by Junior on 17/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import UIKit

class OnRunViewController: LocationViewController {
    
    
    
    @IBOutlet weak var swipeBackgroundImageView: UIImageView!
    @IBOutlet weak var sliderImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwipe(sender:)))
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
        sliderImageView.addGestureRecognizer(swipeGesture)
        sliderImageView.isUserInteractionEnabled = true
    }
    

    
    
    @objc func endRunSwipe(sender: UIPanGestureRecognizer){
        
        let minimumAdjust: CGFloat = 80
        let maximumAdjust: CGFloat = 126
        
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began  || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBackgroundImageView.center.x - minimumAdjust) && sliderView.center.x <= (swipeBackgroundImageView.center.x + maximumAdjust){
                    sliderView.center.x = sliderView.center.x + translation.x
                } else if sliderView.center.x >= (swipeBackgroundImageView.center.x + maximumAdjust) {
                    sliderView.center.x = swipeBackgroundImageView.center.x + maximumAdjust
                    //end run code
                    self.dismiss(animated: true, completion: nil)
                }else{
                    sliderView.center.x = self.swipeBackgroundImageView.center.x - minimumAdjust
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            }else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1) {
                    sliderView.center.x = self.swipeBackgroundImageView.center.x - minimumAdjust
                }
            }
        }else{
            return
        }
    }
    
    
   
}
