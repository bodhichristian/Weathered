//
//  FavoriteLocation.swift
//  Weathered
//
//  Created by christian on 8/8/23.
//

import SwiftUI

struct FavoriteLocationView: View {
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
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 150, height: 100)
                .foregroundStyle(.thinMaterial)
                .shadow(color: .primary.opacity(0.5), radius: 2)
            
            
            VStack(alignment: .leading) {
                HStack {
                    if let conditionCode = weatherData?.current.condition.code {
                        Image(systemName:  daytime // Between 6:00am and 6:00pm
                              ? WeatherIconsDaytime[conditionCode] ?? "sun.fill"
                              : WeatherIconsNighttime[conditionCode] ?? "moon.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    }
                    
                    if let temp = weatherData?.current.tempF {
                        Text("\(Int(temp))°F")
                    }
                }
                .font(.title2)
                .bold()
                
                Text(location.name)
                
                    .font(.headline)
            }
            .fontDesign(fontDesign)
            .padding()
        }
        .padding(.vertical)
        
        .onAppear {
            withAnimation(.bouncy) {
                weatherService.fetchWeatherData(for: location.name) { result in
                    switch result {
                    case .success(let data):
                        weatherData = data
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        .onTapGesture {
            withAnimation{
                viewModel.weatherData = weatherData
                viewingDetails = true
            }
        }
        
    }
}

#Preview {
    FavoriteLocationView(location: SampleData.favoriteLocation, fontDesign: .default, viewingDetails: .constant(false))
}


//WeatherDetailsView(weatherData: weatherData, tintColor: backgroundTopStops.interpolated(amount: weatherData?.location.localtime.calculateTimeOfDay() ?? 0.5))
