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
final class User {
    let id: UUID
    var fontDesign: String
    var showTempInF: Bool
    var favoriteLocations: [Location]
    
    init() {
        self.id = UUID()
        self.fontDesign = "default"
        self.showTempInF = true
        self.favoriteLocations = []
    }
    
    
}
