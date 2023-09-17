//
//  WeatherDetailsView.swift
//  Weathered
//
//  Created by christian on 3/30/23.
//

import SwiftUI

struct SecondaryDetailsView: View {
    let weatherData: WeatherData?

    // Background color
    let tintColor: Color
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(tintColor.opacity(0.25))
                    .frame(height: 430)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 20)
                
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Right now")
                            .font(.headline)
                            .fontWeight(.medium)
                            .padding([.leading, .top], 20)
                            .padding(.bottom, 10)
                        
                        rightNowDetails
                        
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
                                    value: weatherData?.forecast.forecastday[0].astro.sunrise ?? "",
                                    iconName: "sunrise",
                                    color: .yellow
                                )
                                
                                WeatherDetailGridItem(
                                    metric: "Sunset",
                                    value: weatherData?.forecast.forecastday[0].astro.sunset ?? "",
                                    iconName: "sunset",
                                    color: .orange
                                )
                                
                                WeatherDetailGridItem(
                                    metric: "Moonrise",
                                    value: weatherData?.forecast.forecastday[0].astro.moonrise ?? "",
                                    iconName: "moon.stars",
                                    color: .blue
                                )
                                
                                WeatherDetailGridItem(
                                    metric: "Moonset",
                                    value: weatherData?.forecast.forecastday[0].astro.moonset ?? "",
                                    iconName: "moon.zzz",
                                    color: .indigo
                                )
                                
                                Spacer()
                            }
                            .offset(x: -10)
                        
                        .padding(.leading, 20)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    
                
            }
        }
    }
}

struct SecondaryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryDetailsView(weatherData: nil, tintColor: .blue)
            .preferredColorScheme(.dark)
    }
}

extension SecondaryDetailsView {
    private var rightNowDetails: some View {
        Group {
            WeatherDetailRowView(
                metric: "Feels like",
                unit: "°F",
                value: weatherData?.current.tempF ?? 0,
                iconName: "person.fill"
            )
            
            WeatherDetailRowView(
                metric: "Humidity",
                unit: "%",
                value: Double(weatherData?.current.humidity ?? 0),
                iconName: "humidity.fill"
            )
            
            WeatherDetailRowView(
                metric: "Dew point",
                unit: "°F",
                value: weatherData?.forecast.forecastday[0].hour[0].dewpointF ?? 0,
                iconName: "drop.degreesign"
            )
            
            WeatherDetailRowView(
                metric: "Wind",
                unit: "mph",
                value: weatherData?.current.windMph ?? 0,
                iconName: "wind"
            )
            
            WeatherDetailRowView(
                metric: "Visibility",
                unit: "mi",
                value: weatherData?.current.visMiles ?? 0,
                iconName: "eye.fill"
            )
            
            WeatherDetailRowView(
                metric: "UV Index",
                unit: "",
                value: weatherData?.current.uv ?? 0,
                iconName: "sun.max.fill"
            )
        }
    }
}
