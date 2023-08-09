//
//  SearchView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI
import SwiftData
import ImageMorphing

struct SearchView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @Environment(\.modelContext) private var modelContext
    
    @Query var favoriteLocations: [FavoriteLocation]
    
    @Binding var viewingDetails: Bool
    @Binding var fontDesign: Font.Design
    
    @State private var searchText = ""
    @State private var locationName: String?
    @State private var timer: Timer?
    
    
    
    @State private var selectedImage = 0
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(colors: [.midnightStart, .midnightEnd], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                // If weather data has not been fetched
                if viewModel.weatherData == nil {
                    // Morphing Image
                    // Animates when the image passed is updated
                    MorphingImage(systemName: SFSymbolsWeatherIcons[selectedImage])
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                        .onAppear {
                            // Start a timer that updates `selectedImage` at a set interval
                            startAnimation()
                        }
                } else {
                    if let location = viewModel.weatherData?.location {
                        VStack {
                            HStack(spacing: 0){
                                // This Text view is purposefully clear
                                // Ensures center spacing of temperature, balancing the ° on the right
                                Text("°")
                                    .foregroundColor(.clear)
                                    .fontDesign(fontDesign)
                                
                                Text("\(Int(viewModel.weatherData?.current.tempF ?? 0))°")
                                    .font(.system(size: 80))
                                    .foregroundStyle(.white)
                                    .fontDesign(fontDesign)
                                
                            }
                            Text(location.name)
                                .font(.largeTitle)
                                .fontDesign(fontDesign)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                            
                            Text(location.region)
                                .font(.title2)
                                .foregroundColor(.lightCloudEnd)
                                .lineLimit(1)
                            
                            Button {
                                if let weatherData = viewModel.weatherData {
                                    
                                    let newFavorite = FavoriteLocation(
                                        name: weatherData.location.name,
                                        region: weatherData.location.region,
                                        country: weatherData.location.country,
                                        latitude: weatherData.location.lat,
                                        longitude: weatherData.location.lon)
                                    
                                    modelContext.insert(newFavorite)
                                }
                                
                            } label: {
                                Label("Add to favorites", image: "heart")
                            }
                        }
                        .onTapGesture {
                            withAnimation(.spring()){
                                viewingDetails = true
                            }
                        }
                    }
                }
                
                Spacer()
                
                
                HStack {
                    searchBar
                    settingsButton
                }
                
            }
        }
        .onChange(of: searchText) { 
            // Invalidate the previous timer when the user types again
            timer?.invalidate()
            
            // Start a new timer with a 0.5-second delay
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                // This block will be executed  after user stops typing
                DispatchQueue.main.async {
                    viewModel.query = searchText
                    viewModel.fetchWeatherData()
                }
            }
        }
        
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            let lastIndex = SFSymbolsWeatherIcons.count - 1
            if selectedImage == lastIndex {
                selectedImage = 0
            } else {
                selectedImage += 1
            }
        }
        
    }
}

//#Preview {
//    SearchView(viewingDetails: .constant(false),
//               fontDesign: .constant(.default)
//    )
//        .environmentObject(WeatherViewModel())
//        .modelContainer(for: FavoriteLocation.self, inMemory: true)
//}


extension SearchView {
    
    private var searchBar: some View {
        ZStack {
            Capsule()
                .foregroundStyle(.thinMaterial)
                .frame(width: 320, height: 40)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for a location", text: $searchText)
                
            }
            .foregroundStyle(.white)
            .padding()
            .frame(width: 320, height: 40)
        }
        .padding(.vertical)
    }

    private var settingsButton: some View {
        Menu {
            Section(header: Text("Font Design")) {
                Button {
                    fontDesign = .default
                } label: {
                    Text("Default")
                }
                
                Button {
                    fontDesign = .monospaced
                } label: {
                    Text("Monospaced")
                }
                
                Button {
                    fontDesign = .serif
                } label: {
                    Text("Serif")
                }
                
                Button {
                    fontDesign = .rounded
                } label: {
                    Text("Rounded")
                }
                
            }
            
        } label: {
            Image(systemName: "gear")
                .resizable()
                .foregroundColor(.white)
                .scaledToFit()
                .frame(width: 30)
                .shadow(radius: 6, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}
