//
//  SecondViewController.swift
//  relay 2.0
//
//  Created by Chan Qing Hong on 8/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBAction func LocationPressed(_ sender: UIButton) {
        mapChangedFromUserInteraction = false
    }
    //map
    
    @IBOutlet weak var Map: MKMapView!
    private var mapChangedFromUserInteraction = false

    func mapmoved() {
        mapChangedFromUserInteraction = true
    }
    private func mapViewRegionDidChangeFromUserInteraction()  {
        
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MapViewController.mapmoved))
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MapViewController.mapmoved))
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(MapViewController.mapmoved))
        let pinch: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(MapViewController.mapmoved))
        let rotate: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(MapViewController.mapmoved))
        tap.cancelsTouchesInView = false
        pan.cancelsTouchesInView = false
        swipe.cancelsTouchesInView = false
        pinch.cancelsTouchesInView = false
        rotate.cancelsTouchesInView = false
        Map.addGestureRecognizer(swipe)
        Map.addGestureRecognizer(tap)
        Map.addGestureRecognizer(pan)
        Map.addGestureRecognizer(pinch)
        Map.addGestureRecognizer(rotate)
        Map.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }

    


    
    
    let manager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        
    {
        
        
        if mapChangedFromUserInteraction {
      
            
            
        }
        else {
     let location = locations[0]
     
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        Map.setRegion(region, animated: true)
      
        self.Map.showsUserLocation = true
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        self.mapViewRegionDidChangeFromUserInteraction()
        
        
        
    }
    
    func thumbsUpButtonPressed() {
        print("thumbs up button pressed")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

