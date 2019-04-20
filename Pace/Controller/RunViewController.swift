//
//  RunViewController.swift
//  Pace
//
//  Created by Junior on 16/04/2019.
//  Copyright © 2019 capsella. All rights reserved.
//

import UIKit
import MapKit
import Realm
import RealmSwift

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mapView.delegate = self
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        //getLastRun()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setUpMapView()
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager?.stopUpdatingLocation()
    }
    
    
    
    @IBAction func centerMapClicked(_ sender: Any) {
        centerMapOnUserLocation()
    }
    
    
    
    @IBAction func lastRunCloseButtonTapped(_ sender: Any) {
        overLayStackView.isHidden = true
        overLayView.isHidden = true
        lastRunCloseButton.isHidden = true
        centerMapOnUserLocation()
    }
    
    
    
    
    func centerMapOnUserLocation() {
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func centerMapOnPreviousRoute(locations: List<Location>) -> MKCoordinateRegion{
        guard let initialLoc = locations.first else {
            return MKCoordinateRegion()
        }
        var minLat = initialLoc.latitude
        var minLong = initialLoc.longitude
        var maxLat = minLat
        var maxLong = minLong
        
        
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLong = min(minLong, location.longitude)
            maxLat = max(maxLat, location.latitude)
            maxLong = max(maxLong, location.longitude)
        }
        
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2, longitude: (minLong + maxLong)/2), span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.4, longitudeDelta: (maxLong - minLong) * 1.4))
    }
    
    
    
    func setUpMapView(){
        if let overlay = addLastRunToMap() {
            if mapView.overlays.count > 0{
                mapView.removeOverlays(mapView!.overlays)
            }
            mapView.addOverlay(overlay)
            overLayStackView.isHidden = false
            overLayView.isHidden = false
            lastRunCloseButton.isHidden = false
        } else{
            overLayStackView.isHidden = true
            overLayView.isHidden = true
            lastRunCloseButton.isHidden = true
            centerMapOnUserLocation()
            
        }
    }
    
    
    
    
    func addLastRunToMap() -> MKPolyline? {
        
        guard let lastRun = Run.getAllRuns()?.first else {
            return nil
        }
        
        averagePaceLabel.text = lastRun.pace.formatTimeToString()
        distanceLabel.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLabel.text = lastRun.duration.formatTimeToString()
        
        var coordinates = [CLLocationCoordinate2D]()
        for location in lastRun.locations {
            coordinates.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        
        
        mapView.userTrackingMode = .none
        mapView.setRegion(centerMapOnPreviousRoute(locations: lastRun.locations), animated: true)
        
        
        return MKPolyline(coordinates: coordinates, count: lastRun.locations.count)
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
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        renderer.lineWidth = 4
        
        return renderer
    }

}
