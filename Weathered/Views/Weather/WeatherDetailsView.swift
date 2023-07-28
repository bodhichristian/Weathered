//
//  WeatherDetailsView.swift
//  Weathered
//
//  Created by christian on 3/30/23.
//

import SwiftUI

struct WeatherDetailsView: View {
    let weatherData: WeatherData?

    // Background color
    let tintColor: Color
    
//    let residueType: Storm.Contents
//    let resiudeStrength: Double
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
//            ResidueView(type: residueType, strength: resiudeStrength)
//                .frame(height: 62)
//                .offset(y: 230)
//                .zIndex(1)
            
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
                                WeatherDetailGridItem(
                                    metric: "Sunrise",
                                    value: weatherData?.forecast.forecastday[0].astro.sunrise ?? "",
                                    iconName: "sunrise"
                                )
                                
                                WeatherDetailGridItem(
                                    metric: "Sunset",
                                    value: weatherData?.forecast.forecastday[0].astro.sunset ?? "",
                                    iconName: "sunset"
                                )
                                
                                WeatherDetailGridItem(
                                    metric: "Moonrise",
                                    value: weatherData?.forecast.forecastday[0].astro.moonrise ?? "",
                                    iconName: "moon.stars"
                                )
                                
                                WeatherDetailGridItem(
                                    metric: "Moonset",
                                    value: weatherData?.forecast.forecastday[0].astro.moonset ?? "",
                                    iconName: "moon.zzz"
                                )
                            }
                        
                        .padding(.leading, 20)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    
                
            }
            //.padding(.top, 200)
        }
        //.offset(y: 10)
    }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(weatherData: nil, tintColor: .blue)
            .preferredColorScheme(.dark)
    }
}

extension WeatherDetailsView {
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
