//
//  ViewController.swift
//  AreaMeasurement
//
//  Created by First User on 1/31/16.
//  Copyright © 2016 Daniel_Cleary. All rights reserved.
// GitRepo : DclearEE/AreaMeasurement

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Location delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    

    @IBAction func AddPin(sender: UILongPressGestureRecognizer) {
        
        let location = sender.locationInView(self.mapView)
        let loCoord = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = loCoord
        annotation.title = "Pin"
        
        self.mapView.addAnnotation(annotation)
        
    }
    
    
}
