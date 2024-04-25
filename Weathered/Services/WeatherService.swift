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
    // This function fetches weather data for a given city using WeatherAPI.
    // The completion handler returns a Result object containing either WeatherData on success or an Error on failure.
    func fetchWeatherData(for city: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        
        
        // Uncomment the following line
        // let apiKey = "ENTER YOUR API KEY HERE" // Replace this string with your WeatherAPI API key.
        
        
        // Replace interpolated `christiansKey` with `apiKey`
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(christiansKey)&q=\(city)&days=1&aqi=no&alerts=no"

        // Create a URL object from the constructed URL string.
        guard let url = URL(string: urlString) else {
            // If the URL is invalid, call the completion handler with a failure result and return early.
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let session = URLSession.shared
        // Create a data task to fetch data from the WeatherAPI using the provided URL.
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                // If there's an error during the network request,
                // call the completion handler with a failure result and return early.
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }

            // Check if data is received from the server.
            guard let data = data else {
                // If no data is received, call the completion handler with a failure result and return early.
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                print("No data received")
                return
            }

            do {
                // Try to decode the received JSON data into a WeatherData object using JSONDecoder.
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                // If decoding is successful, call the completion handler with the WeatherData object.
                completion(.success(weatherData))
                print(weatherData)
            } catch {
                // If there's an error during JSON decoding, call the completion handler with a failure result and return early.
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }

        // Resume the data task to initiate the network request.
        task.resume()
    }
}
