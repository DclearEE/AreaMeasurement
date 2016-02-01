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
    
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
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
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    

    @IBAction func AddPin(sender: UILongPressGestureRecognizer) {
        
        if(sender.state == UIGestureRecognizerState.Began) {
            // Do Beginning work here when finger is intially pressed
            print("Long press Began")
            
            let location = sender.locationInView(self.mapView)
            let pinCoord = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
            let annotation = MKPointAnnotation()
            
            
            annotation.coordinate = pinCoord
            annotation.title = "Pin"
            self.mapView.addAnnotation(annotation)
            print(pinCoord.latitude, pinCoord.longitude)
        
        }
        if (sender.state == UIGestureRecognizerState.Began) {
            // Do repeated work here (repeats continuously) while finger is down
            print("Changed press detected.")
        }
        else if (sender.state == UIGestureRecognizerState.Ended) {
            // Do end work here when finger is lifted
            print("Long press detected.")
        }
        
        
    }
    
    func mapView(mapView: MKMapView,
        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
            self.pinAnnotationView.draggable = true
            self.pinAnnotationView.canShowCallout = true
            return self.pinAnnotationView
    }
    
    
}
