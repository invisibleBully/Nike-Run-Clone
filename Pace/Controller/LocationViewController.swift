//
//  LocationViewController.swift
//  Pace
//
//  Created by Junior on 16/04/2019.
//  Copyright © 2019 capsella. All rights reserved.


import UIKit
import MapKit

class LocationViewController: UIViewController, MKMapViewDelegate {

    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.activityType = .fitness
    }
    
    
    
    func checkLocationAuthStatus(){
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    
}
