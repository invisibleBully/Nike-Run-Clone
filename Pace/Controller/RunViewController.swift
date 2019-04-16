//
//  RunViewController.swift
//  Pace
//
//  Created by Junior on 16/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import UIKit
import MapKit

class RunViewController: LocationViewController {
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager?.stopUpdatingLocation()
    }
    
    
    
    @IBAction func centerMapClicked(_ sender: Any) {
        
    }
    

}



extension RunViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
        
    }
    
}
