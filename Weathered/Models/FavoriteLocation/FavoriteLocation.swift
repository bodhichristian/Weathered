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
    let id: UUID
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    
    init(id: UUID = UUID(),
         name: String,
         region: String,
         country: String,
         latitude: Double,
         longitude: Double) {
        self.id = id
        self.name = name
        self.region = region
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
