//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI
import SwiftData

//@available(iOS 17.0, *)
struct ContentView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    //@Query var favoriteLocations: [FavoriteLocation]
    
    @State private var viewingDetails = false
    @State private var fontDesign: Font.Design = .default
    
    var body: some View {
        if viewingDetails {
            if let weatherData = viewModel.weatherData {
                WeatherView(weatherData: weatherData,
                            fontDesign: fontDesign,
                            viewingDetails: $viewingDetails
                )
            }
        } else {
            SearchView(viewingDetails: $viewingDetails,
                       fontDesign: $fontDesign
            )
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: FavoriteLocation.self, inMemory: true)
}


