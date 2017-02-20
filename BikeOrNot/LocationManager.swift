//
//  LocationManager.swift
//  BikeOrNot
//
//  Created by Joel Bell on 10/16/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func determinedInitialLocation(sender: LocationManager)
}

class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    
    weak var locationManagerDelegate: LocationManagerDelegate?
    var placemark: CLPlacemark?
    
    static let shared = LocationManager()
    
    var hasInitialLocation: Bool = false {
        didSet {
            locationManagerDelegate?.determinedInitialLocation(sender: self)
        }
    }
    
    private override init() {
        super.init()
        
        self.delegate = self
        self.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.startUpdatingLocation()
        }
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !hasInitialLocation {
            hasInitialLocation = true
        }
        
    }
    
    func authorize() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            self.requestWhenInUseAuthorization()
        case .denied, .restricted:
            // TO DO: present alert to user to change settings
            print("ALERT: User denied/restricted location access")
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

}
