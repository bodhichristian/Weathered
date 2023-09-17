//
//  WeatheredApp.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI
import SwiftData

@main
struct WeatheredApp: App {
    @StateObject var weatherVM = WeatherViewModel()
    @StateObject var locationVM = LocationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(weatherVM)
                .environmentObject(locationVM)
        }
        .modelContainer(for: FavoriteLocation.self)
    }
}
