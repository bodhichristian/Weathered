//
//  CurrentLocationView.swift
//  Weathered
//
//  Created by christian on 9/5/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct CurrentLocationView: View {
    let currentLocation: CLLocationCoordinate2D
    let weatherService = WeatherService()
    
    @State private var weatherData: WeatherData?
    
    var query: String {
        "\(currentLocation.latitude), \(currentLocation.longitude)"
    }
    
    var daytime: Bool {
        (weatherData?.location.localtime.calculateTimeOfDay() ?? 0.5) > 0.25
        && (weatherData?.location.localtime.calculateTimeOfDay() ?? 0.5 < 0.75)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        if let weatherData {
                            Image(systemName: "location")
                                .font(.title2)
                            
                            Image(systemName:  daytime
                                  // Between 6:00am and 5:59pm
                                  ? WeatherIconsDaytime[weatherData.current.condition.code] ?? ""
                                  // Between 6:00pm and 5:59am
                                  : WeatherIconsNighttime[weatherData.current.condition.code] ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .symbolRenderingMode(.multicolor)
                            
                            
                            Text("\(Int(weatherData.current.tempF))°F" )
                                .font(.title2)
                        }
                    }
                    
                    HStack {
                        Text(weatherData?.location.name ?? "")
                            .bold()
                        Text(weatherData?.location.region ?? "")
                    }
                    
                }
                .foregroundStyle(.white.opacity(0.7))
                .padding(.leading)
                
                Spacer()
            }
            
        }
        .onAppear {
            weatherService.fetchWeatherData(for: query) { result in
                switch result {
                case .success(let data):
                    weatherData = data
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
}

#Preview {
    CurrentLocationView(currentLocation: CLLocationCoordinate2DMake(SampleData.weather.location.lat, SampleData.weather.location.lon))
}
