//
//  WeatherViewModel.swift
//  Weathered
//
//  Created by christian on 7/24/23.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    
    var query = ""
    let weatherService = WeatherService()
    
    func fetchWeatherData() {
        weatherService.fetchWeatherData(for: query) { result in
            print(result)
            switch result {
            case .success(let data):
                self.weatherData = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
