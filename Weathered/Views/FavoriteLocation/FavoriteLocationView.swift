//
//  FavoriteLocation.swift
//  Weathered
//
//  Created by christian on 8/8/23.
//

import SwiftUI

struct FavoriteLocationView: View {
    let weatherService = WeatherService()
    let location: FavoriteLocation
    let fontDesign: Font.Design
    
    @State private var weatherData: WeatherData?
    
    var body: some View {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 100)
                    .foregroundStyle(.thinMaterial)
                    .shadow(color: .primary.opacity(0.5), radius: 2)
                
                
                VStack(alignment: .leading) {
                    HStack {
                        if let conditionCode = weatherData?.current.condition.code {
                            Image(systemName: WeatherIconsDaytime[conditionCode] ?? "sun")
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
    }
}

#Preview {
    FavoriteLocationView(location: SampleData.favoriteLocation, fontDesign: .default)
}
