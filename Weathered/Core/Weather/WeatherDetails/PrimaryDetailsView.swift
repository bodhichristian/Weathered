//
//  PrimaryDetailsView.swift
//  Weathered
//
//  Created by christian on 8/28/23.
//

import SwiftUI

struct PrimaryDetailsView: View {
    let weatherData: WeatherData
    let fontDesign: Font.Design
    
    var low: Int {
        Int(weatherData.forecast.forecastday[0].day.mintempF)
    }
    
    var high: Int {
        Int(weatherData.forecast.forecastday[0].day.maxtempF)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Date
            Text(weatherData.location.localtime.getDate())
                .font(.title3)
                .fontDesign(fontDesign)
                .fontWeight(.medium)
                .shadow(radius: 3)
            // Time
            Text(weatherData.location.localtime.getTime())
                .font(.system(size: 70))
                .fontDesign(fontDesign)
                .fontWeight(.medium)
            // Location Name
            Text(weatherData.location.name)
                .lineLimit(1)
                .fontDesign(fontDesign)
                .font(.system(size: 45))
                .padding(.top, -10)
            // Region Name
            Text(weatherData.location.region)
                .font(.headline)
                .opacity(0.8)
                .padding(.top, 6)
                .padding(.bottom, 25)
            
            // Temperature
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    // Feels Like
                    Text("Feels like \(Int(weatherData.current.feelslikeF))°F")
                        .font(.headline)
                    // Current conditions text description
                    Text(weatherData.current.condition.text)
                    // Current day's low and high temps
                    HStack {
                        Text("L \(low)°")
                        
                        Text("H \(high)°")
                    }
                }
                Spacer()
                
                // Current Temperature
                Text("\(Int(weatherData.current.tempF))°")
                    .font(.system(size: 96))
                    .fontDesign(fontDesign)
                    .fontWeight(.ultraLight)
                    .offset( y: -18)
                
            }
            .padding(.horizontal, 30)
            .padding(.bottom, -15)
        }
    }
}

#Preview {
    PrimaryDetailsView(weatherData: SampleData.weather, fontDesign: .default)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
