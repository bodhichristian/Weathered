//
//  User.swift
//  Weathered
//
//  Created by christian on 8/7/23.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class FavoriteLocation {

    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    
    init(name: String,
         region: String,
         country: String,
         latitude: Double,
         longitude: Double) {
        self.name = name
        self.region = region
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
