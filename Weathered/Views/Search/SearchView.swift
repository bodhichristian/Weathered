//
//  SearchView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @State private var searchText = ""
    @State private var locationName: String?
    @State private var timer: Timer?
    
    @Binding var viewingDetails: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.midnightStart, .midnightEnd], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                if let location = viewModel.weatherData?.location {
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
            .onTapGesture {
                withAnimation(.spring()){
                    viewingDetails = true
                }
            }
            
            
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
        }
        .onChange(of: searchText) { query in
            // Invalidate the previous timer when the user types again
            timer?.invalidate()
            
            // Start a new timer with a 2-second delay
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                // This block will be executed after 2 seconds of the user stopping typing
                DispatchQueue.main.async {
                    viewModel.query = query
                    viewModel.fetchWeatherData()
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewingDetails: .constant(false))
    }
}
