//
//  WeatherService.swift
//  Weathered
//
//  Created by christian on 7/24/23.
//

import Foundation

// MARK: WeatherService
// A service class for fetching weather data

class WeatherService: ObservableObject {    
    func fetchWeatherData(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
            let apiKey = "eff192195d53420dbab02924232407"
            let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=1&aqi=no&alerts=no"

            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    print("Error 1: " + error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                    print("No data received")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherData.self, from: data)
                    completion(.success(weatherData))
                    print(weatherData)
                } catch {
                    completion(.failure(error))
                    print("ERROR 2: " + error.localizedDescription)
                }
            }
            
            task.resume()
        }
}
