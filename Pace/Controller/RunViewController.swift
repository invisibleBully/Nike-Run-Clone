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
    
    @IBOutlet weak var overLayStackView: UIStackView!
    @IBOutlet weak var overLayView: UIView!
    @IBOutlet weak var lastRunCloseButton: UIButton!
    @IBOutlet weak var averagePaceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        getLastRun()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager?.stopUpdatingLocation()
    }
    
    
    
    @IBAction func centerMapClicked(_ sender: Any) {
        
    }
    
    
    
    @IBAction func lastRunCloseButtonTapped(_ sender: Any) {
        overLayStackView.isHidden = true
        overLayView.isHidden = true
        lastRunCloseButton.isHidden = true
    }
    
    func getLastRun() {
        guard let lastRun = Run.getAllRuns()?.first else {
            overLayStackView.isHidden = true
            overLayView.isHidden = true
            lastRunCloseButton.isHidden = true
            return
        }
        
        overLayStackView.isHidden = false
        overLayView.isHidden = false
        lastRunCloseButton.isHidden = false
        
        averagePaceLabel.text = lastRun.pace.formatTimeToString()
        distanceLabel.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLabel.text = lastRun.duration.formatTimeToString()
        
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
