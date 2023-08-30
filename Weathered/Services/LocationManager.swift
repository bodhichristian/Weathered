//
//  LocationManager.swift
//  Weathered
//
//  Created by christian on 8/29/23.
//

import Foundation
import CoreLocation

//MARK: LocationManager
// Responsible for managing Location Services (LS) and authorizations.

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var manager: CLLocationManager?
    
    // Checks if LS is enabled, configures location manager
    func checkIfLocationServicesIsEnabled() {
            manager = CLLocationManager()
            manager?.delegate = self
            manager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Checks current authorization status afor LS
    private func checkLocationAuthorization() {
        guard let manager = manager else { return }
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location Services restriced.")
        case .denied:
            print("This app has been denied Location Services.")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    // Called when LS authorization status has changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

