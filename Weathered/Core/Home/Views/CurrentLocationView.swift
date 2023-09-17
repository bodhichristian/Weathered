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
    let fontDesign: Font.Design
    
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
                if let weatherData {
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                                .font(.title3)
                            
                            Text("\(Int(weatherData.current.tempF))°F" )
                                .font(.title2)
                                .fontDesign(fontDesign)
                                .bold()
                        }
                        
                        HStack {
                            Image(systemName:  daytime
                                  // Between 6:00am and 5:59pm
                                  ? WeatherIconsDaytime[weatherData.current.condition.code] ?? ""
                                  // Between 6:00pm and 5:59am
                                  : WeatherIconsNighttime[weatherData.current.condition.code] ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .symbolRenderingMode(.multicolor)
                            HStack {
                                Text(weatherData.location.name)
                                    .bold()
                                Text(weatherData.location.region)
                            }
                            .fontDesign(fontDesign)
                        }
                        
                    }
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.leading)
                }
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
    CurrentLocationView(currentLocation: CLLocationCoordinate2DMake(SampleData.weather.location.lat, SampleData.weather.location.lon), fontDesign: .default)
}
