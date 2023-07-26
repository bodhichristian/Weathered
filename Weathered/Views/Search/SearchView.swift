//
//  SearchView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchVM = WeatherViewModel()
    
    @State private var searchText = ""
    
    @State private var locationName: String?
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.midnightStart, .midnightEnd], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            
            
            VStack {
                
                if let location = searchVM.weatherData?.location {
                    Text(location.name)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                    
                    Text(location.region)
                        .font(.title2)
                        .foregroundColor(.lightCloudEnd)
                        .lineLimit(1)
                }
            }
            .offset(y: -80)
                // Search Field
                ZStack {
                    Capsule()
                        .foregroundStyle(.ultraThinMaterial)
                        .frame(width: 350, height: 40)

                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search for a location", text: $searchText)
                            
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 350, height: 40)
                }
            
            
            // Search Button
            
        }
        .onChange(of: searchText) { query in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                searchVM.query = query
                withAnimation{
                    searchVM.fetchWeatherData()
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
