//
//  WeatheredApp.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI

@main
struct WeatheredApp: App {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
