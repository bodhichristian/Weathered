//
//  FavoriteLocation.swift
//  Weathered
//
//  Created by christian on 8/8/23.
//

import SwiftUI

struct FavoriteLocationTile: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    let weatherService = WeatherService()
    let location: FavoriteLocation
    let fontDesign: Font.Design
    
    @Binding var viewingDetails: Bool
    
    @State private var weatherData: WeatherData?
    
    var daytime: Bool {
        (weatherData?.location.localtime.calculateTimeOfDay() ?? 0.5) > 0.25
        && (weatherData?.location.localtime.calculateTimeOfDay() ?? 0.5 < 0.75)
    }
    
    var prefix: Int {
        switch fontDesign {
        case .monospaced:
            return 10
        default:
            return 14
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            // Thin material frame
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 165, height: 110) // 3:2
                .foregroundStyle(.thinMaterial)
                //.shadow(color: .primary.opacity(0.5), radius: 2)
            
            // Current weather preview
            VStack(alignment: .leading) {
                HStack { // Icon and temperature
                    // If a condition code has been received, display an icon
                    if let conditionCode = weatherData?.current.condition.code {
                        Image(systemName:  daytime
                              // Between 6:00am and 5:59pm
                              ? WeatherIconsDaytime[conditionCode] ?? "sun.fill"
                              // Between 6:00pm and 5:59am
                              : WeatherIconsNighttime[conditionCode] ?? "moon.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .symbolRenderingMode(.multicolor)
                    }
                    
                    if let temp = weatherData?.current.tempF {
                        Text("\(Int(temp))°F")
                    }
                }
                .font(.title2)
                .bold()
                
                Text(location.name.prefix(prefix))
                    
                    .font(.headline)
            }
            .fontDesign(fontDesign)
            .padding()
        }
        .padding(.vertical)
        
        .onAppear {
                weatherService.fetchWeatherData(for: location.name) { result in
                    switch result {
                    case .success(let data):
                        weatherData = data
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            
        }
        
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.3)){
                viewModel.weatherData = weatherData
                viewingDetails = true
            }
        }
        
    }
}

//#Preview {
//    FavoriteLocationView(location: SampleData.favoriteLocation, fontDesign: .default, viewingDetails: .constant(false))
//}
