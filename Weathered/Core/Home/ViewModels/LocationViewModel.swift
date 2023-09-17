//
//  HomeViewModel.swift
//  Weathered
//
//  Created by christian on 9/16/23.
//

import Foundation
import SwiftUI
import MapKit

class LocationViewModel: ObservableObject {
    @Published var locationManager: LocationManager
    @Published var userLocationKnown: Bool
    @Published var position: MapCameraPosition
    @Published var heading: Double
    @Published var mapStyle: MapStyle
    
    init() {
        self.locationManager = LocationManager()
        self.userLocationKnown = false
        self.position = .automatic
        self.heading = 10.0
        self.mapStyle = .imagery(elevation: .realistic)
    }
    
    func updateUserLocation() {
        locationManager.checkIfLocationServicesIsEnabled()
        if let userLocation = locationManager.manager?.location {
                userLocationKnown = true
                position = .camera(MapCamera(centerCoordinate: userLocation.coordinate, distance: 18000, heading: heading, pitch: 60))
        }
    }
}
