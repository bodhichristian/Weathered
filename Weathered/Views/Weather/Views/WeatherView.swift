//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI


struct WeatherView: View {
    let weatherData: WeatherData
    
    @Binding var viewingDetails: Bool
    
    @State private var time = 0.1
    @State private var lightningMaxBolts = 4.0
    @State private var lightningForkProbability = 20.0
    @State private var showingControls = false
    
    let residueType =  Storm.Contents.none
    let resiudeStrength = 0.0
    
    var low: Int {
        Int(weatherData.forecast.forecastday[0].day.mintempF)
    }
    
    var high: Int {
        Int(weatherData.forecast.forecastday[0].day.maxtempF)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                SkyView(weatherData: weatherData)
                
                
                ResidueView(type: residueType, strength: resiudeStrength)
                    .frame(height: 62)
                    .offset(y: -65)
                    .zIndex(1)
                
                weatherDetails // Current Location and Weather conditions
                
                LightningView(maximumBolts: Int(lightningMaxBolts), forkProbability: Int(lightningForkProbability))
                
               backToSearch
                
            }
            // This toolbar is currently necessary to keep the alpha layer intentionally empty
            // This is a temporary solution while the weather animation depends on the alpha layer
            // Removing content from this toolbar will result in a WeatherView UI that animates undesireably.
            .toolbar {
                Text("")
            }
            .preferredColorScheme(.dark)
        }
        
    }
    
    // Convert time double into a neatly formatted string
    var formattedTime: String {
        let start = Calendar.current.startOfDay(for: Date.now)
        let advanced = start.addingTimeInterval(time * 24 * 60 * 60)
        return advanced.formatted(date: .omitted, time: .shortened)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(
            weatherData: SampleWeatherData,
            viewingDetails: .constant(true)
            
        )
    }
}


extension WeatherView {
    // All weather details, inside and outside of rounded rect
    private var weatherDetails: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(weatherData.location.localtime.getDate())
                .font(.title3)
                .fontWeight(.medium)
                .shadow(radius: 3)
            
            Text(weatherData.location.localtime.getTime())
                .font(.system(size: 70))
            //.fontDesign(.serif)
                .fontWeight(.medium)
            
            
            
            Text(weatherData.location.name)
                .lineLimit(1)
                .font(.system(size: 45))
                .padding(.top, -10)
            
            
            Text(weatherData.location.region)
                .font(.headline)
                .opacity(0.8)
                .padding(.top, 6)
                .padding(.bottom, 25)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Feels like \(Int(weatherData.current.feelslikeF))° F")
                        .font(.headline)
                    Text(weatherData.current.condition.text)
                    
                    HStack {
                        Text("L \(low)°")
                        
                        Text("H \(high)°")
                    }
                }
                Spacer()
                
                Text("\(Int(weatherData.current.tempF))°")
                    .font(.system(size: 96))
                    .fontWeight(.ultraLight)
                    .offset( y: -18)
                
            }
            .padding(.horizontal, 30)
            .padding(.bottom, -15)
            
            WeatherDetailsView(
                weatherData: weatherData,
                tintColor: backgroundTopStops.interpolated(amount: time)
            )
        }
        .padding(.leading, 5)
        .shadow(color: .black.opacity(0.6), radius: 6, y: 4)

    }
    // Magnifying glass button
    private var backToSearch: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                HStack {
                    Button {
                        withAnimation(.spring()) {
                            viewingDetails = false
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .shadow(radius: 6, y: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.leading, 30)
                    .padding(.top, 90)
                    Spacer()
                }
                Spacer()

            }
        }
        .ignoresSafeArea()
    }
}

