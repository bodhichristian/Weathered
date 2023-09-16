//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var weatherVM: WeatherViewModel
    @EnvironmentObject var locationVM: LocationViewModel
    
    
    @State private var viewingDetails = false
    @State private var fontDesign: Font.Design = .default
    
    var body: some View {
        if viewingDetails {
            if let weatherData = weatherVM.weatherData {
                ConditionsView(
                    weatherData: weatherData,
                    fontDesign: fontDesign,
                    viewingDetails: $viewingDetails
                )
            }
        } else {
            HomeView(
                viewingDetails: $viewingDetails,
                fontDesign: $fontDesign
            )

        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: FavoriteLocation.self, inMemory: true)
}


