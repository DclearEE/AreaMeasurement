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
    var dragPin: MKPointAnnotation!
    let annotation = MKPointAnnotation()
    var latAndLon = [[Int]]()
    var annotationCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
        //self.mapView.mapType = MKMapType.Satellite //Satelite map
        
//        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "addPin:")
//        gestureRecognizer.numberOfTouchesRequired = 1
//        mapView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//      MARK: - Location delegate Methods
    
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
    
    func addPin(gestureRecognizer:UIGestureRecognizer){
        let touchPoint = gestureRecognizer.locationInView(mapView)
        let newCoordinates = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
        if dragPin != nil {
            dragPin.coordinate = newCoordinates
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            dragPin = MKPointAnnotation()
            dragPin.coordinate = newCoordinates
            dragPin.title = "Fuck"
            mapView.addAnnotation(dragPin)
            
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            print(dragPin.coordinate)
            
//Create Array of newly created annotation coordinates for MKPolygon
//            let num = 2
//            let latAndLon[0,1]
            
            
            dragPin = nil
        }
    }
    
//      Does Nothing
    
    func mapView(mapView: MKMapView, viewForAnnotation dragPin: MKAnnotation) -> MKAnnotationView? {
        if dragPin is MKPointAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: dragPin, reuseIdentifier: "dragPin")
            
            pinAnnotationView.pinTintColor = UIColor.purpleColor()
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            
            return pinAnnotationView

        }
        return nil
    }
    
//      Does Nothing
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let lat = view.annotation?.coordinate.latitude
        let long = view.annotation?.coordinate.longitude
        
        print("Clic pin lat \(lat) long \(long)")
        
    }
    
    
}