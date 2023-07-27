//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    @State private var viewingDetails = false
    
    var body: some View {
        if viewingDetails {
            if let weatherData = viewModel.weatherData {
                WeatherView(weatherData: weatherData, viewingDetails: $viewingDetails)
                    
            }
        } else {
            SearchView(viewingDetails: $viewingDetails)
                .environmentObject(viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WeatherViewModel())
    }
}
