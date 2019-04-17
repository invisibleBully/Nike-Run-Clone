//
//  OnRunViewController.swift
//  Pace
//
//  Created by Junior on 17/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import UIKit
import MapKit

class CurrentRunViewController: LocationViewController {
    
    

    @IBOutlet weak var swipeBackgroundImageView: UIImageView!
    @IBOutlet weak var sliderImageView: UIImageView!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    var timer = Timer()
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var runDistance = 0.0
    var timerCount = 0
    var pace = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwipe(sender:)))
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
        sliderImageView.addGestureRecognizer(swipeGesture)
        sliderImageView.isUserInteractionEnabled = true
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        locationManager?.delegate = self
        locationManager?.distanceFilter = 10
        startRun()
    }
    
    func startRun(){
        locationManager?.startUpdatingLocation()
        startTimer()
    }
    
    
    func endRun(){
        locationManager?.stopUpdatingLocation()
    }
    
    
    
    func startTimer(){
        durationLabel.text = timerCount.formatTimeToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    
    
    func calculatePace(time seconds: Int, miles: Double) -> String{
        pace = Int(Double(seconds) / miles)
        print("Pace: \(pace)")
        return pace.formatTimeToString()
    }
    
    
    @objc func updateCounter(){
        timerCount += 1
        durationLabel.text = timerCount.formatTimeToString()
    }
    

    @IBAction func pauseButtonPressed(_ sender: Any) {
        
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


extension CurrentRunViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            checkLocationAuthStatus()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        }else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            distanceLabel.text = "\(runDistance.metersToMiles(places: 2))"
            if timerCount > 0 && runDistance > 0 {
                paceLabel.text = calculatePace(time: timerCount, miles: runDistance.metersToMiles(places: 2))
            }
        }
        lastLocation = locations.last
    }
    
}
