//
//  SolarLunarEventsView.swift
//  Weathered
//
//  Created by christian on 8/28/23.
//

import SwiftUI

struct SolarLunarEventsView: View {
    let weatherData: WeatherData
    
    var body: some View {
        VStack {
            Text("Today")
                .font(.headline)
                .fontWeight(.medium)
                .padding(.leading, 20)
                .padding(.top)
                .padding(.bottom, 10)
            
                HStack(spacing: 10) {
                    Spacer()
                    
                    WeatherDetailGridItem(
                        metric: "Sunrise",
                        value: weatherData.forecast.forecastday[0].astro.sunrise,
                        iconName: "sunrise",
                        color: .yellow
                    )
                    
                    WeatherDetailGridItem(
                        metric: "Sunset",
                        value: weatherData.forecast.forecastday[0].astro.sunset,
                        iconName: "sunset",
                        color: .orange
                    )
                    
                    WeatherDetailGridItem(
                        metric: "Moonrise",
                        value: weatherData.forecast.forecastday[0].astro.moonrise,
                        iconName: "moon.stars",
                        color: .blue
                    )
                    
                    WeatherDetailGridItem(
                        metric: "Moonset",
                        value: weatherData.forecast.forecastday[0].astro.moonset,
                        iconName: "moon.zzz",
                        color: .indigo
                    )
                    
                    Spacer()
                }
        }
    }
}

#Preview {
    SolarLunarEventsView(weatherData: SampleData.weather)
}
