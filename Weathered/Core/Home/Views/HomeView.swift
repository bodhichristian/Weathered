//
//  SearchView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI
import MapKit
import SwiftData

struct HomeView: View {
    @EnvironmentObject var weatherVM: WeatherViewModel
    @EnvironmentObject var locationVM: LocationViewModel
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \FavoriteLocation.name, order: .forward, animation: .smooth) var favoriteLocations: [FavoriteLocation]
    
    @Binding var viewingDetails: Bool
    @Binding var fontDesign: Font.Design
    
    @State private var searchText = ""
    
    @State private var searchTimer: Timer?
    @State private var isSearching = false
    @State private var searchResultsNeeded = false
    
    @State private var curtainOpacity = 1.0
    
    private var locationIsFavorite: Bool {
        favoriteLocations.contains { $0.name == weatherVM.weatherData?.location.name ?? searchText }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Map(position: $locationVM.position)
                    .mapStyle(locationVM.mapStyle)
                    .ignoresSafeArea()
                
                // Gradient Overlay
                LinearGradient(colors: [.midnightEnd, .midnightStart], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .opacity(0.85)
                
                // Curtain reveals Map
                Color.black
                    .ignoresSafeArea()
                    .opacity(curtainOpacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.8)){
                            curtainOpacity = 0.0
                        }
                    }
                
                VStack { // Greeting, Favorite Locations, Search
                    Spacer()
                    if !searchResultsNeeded {
                        GreetingView(fontDesign: fontDesign)

                        Spacer()
                        Spacer()
                        
                        if let currentLocation = locationVM.locationManager.manager?.location?.coordinate {
                            let location = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                            
                            CurrentLocationView(currentLocation: location, fontDesign: fontDesign)
                                .padding(.bottom, 20)
                                .offset(y: isSearching ? 1000 : 0)
                        }
                    }
                    
                    favoriteLocationsView // Visible if user has added a favorite location
                    toolBarView // Search and Settings
                }
                
                VStack { // Search Results
                    if weatherVM.weatherData != nil && searchResultsNeeded {
                        HStack {
                            VStack(alignment: .leading) {
                                Spacer()
                                searchResultsView
                                addToFavoritesView
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            .offset(y: isSearching ? -60 : 0)
                            .onTapGesture {
                                hideResults()
                            }
                            .padding()
                            
                            Spacer()
                        }
                    }
                }
            }
            .onChange(of: searchText) {
                createQuery()
            }
            .onAppear {
                updateMap()
            }
        }
    }
}

// Known Issue:
// Xcode 15.0 beta 1 bug causing models to fail when previews use a modelContainer
//#Preview {
//    HomeView(viewingDetails: .constant(false),
//               fontDesign: .constant(.default)
//    )
//        .environmentObject(WeatherViewModel())
//        .modelContainer(for: FavoriteLocation.self, inMemory: true)
//}

extension HomeView {
    private var searchResultsView: some View {
        VStack(alignment: .leading) {
            Text("\(Int(weatherVM.weatherData?.current.tempF ?? 0))°")
                .font(.system(size: 100))
                .foregroundStyle(.white)
                .fontDesign(fontDesign)
            
            
            Text(weatherVM.weatherData?.location.name.prefix(25) ?? "")
                .font(.largeTitle)
                .fontDesign(fontDesign)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .lineLimit(1)
            
            Text(weatherVM.weatherData?.location.region ?? "")
                .font(.title2)
                .foregroundColor(.lightCloudEnd)
                .lineLimit(1)
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.3)){
                if isSearching {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                viewingDetails = true
            }
        }
    }
    
    private var addToFavoritesView: some View {
        Button {
            if let weatherData = weatherVM.weatherData {
                let newFavorite = FavoriteLocation(
                    name: weatherData.location.name,
                    region: weatherData.location.region,
                    country: weatherData.location.country,
                    latitude: weatherData.location.lat,
                    longitude: weatherData.location.lon)
                
                modelContext.insert(newFavorite)
                do {
                    try modelContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        } label: {
            
            Label("Favorite", systemImage: locationIsFavorite ? "heart.fill" : "heart")
                .symbolRenderingMode(.multicolor)
                .padding(.top, 2)
        }
        .tint(.white)
        .disabled(locationIsFavorite)
    }
    
    private var favoriteLocationsView: some View {
        VStack {
            if !favoriteLocations.isEmpty {
                HStack {
                    Text("Favorite Locations")
                        .font(.callout)
                        .foregroundStyle(.white.opacity(0.7))
                        .padding(.leading)
                        .padding(.bottom, -10)
                    Spacer()
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(favoriteLocations) { location in
                        FavoriteLocationTile(location: location, fontDesign: fontDesign, viewingDetails: $viewingDetails)
                            .contextMenu {
                                
                                Button {
                                    modelContext.delete(location)
                                } label: {
                                    Label("Delete", image: "trash")
                                }
                            }
                        
                            .onTapGesture {
                                hideResults()
                            }
                    }
                }
                .padding(.leading)
            }
        }
    }
    
    private var toolBarView: some View {
        HStack(spacing: 0) {
            searchBar
                .offset(x: 10)
            Spacer()
            if isSearching {
                Button { // Dismiss system keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    withAnimation {
                        isSearching = false
                    }
                } label: {
                    Text("Done")
                        .frame(width: 50, height: 30)
                }
                .tint(.white)
            } else {
                settingsButton
            }
            Spacer()
        }
        .padding(.bottom)
    }
    
    private var searchBar: some View {
        ZStack {
            Capsule()
                .foregroundStyle(.thinMaterial)
                .frame(width: 310, height: 40)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 5)
                TextField("Search for a location", text: $searchText)
                    .autocorrectionDisabled()
                    .onTapGesture {
                        isSearching = true
                    }
                Spacer()
                
                if isSearching && !searchText.isEmpty {
                    Button {
                        searchText = ""
                        weatherVM.weatherData = nil
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing, 5)
                }
            }
            .foregroundStyle(.white)
            .padding()
            .frame(width: 320, height: 40)
        }
    }
    
    private var settingsButton: some View {
        Menu {
            Section(header: Text("Map Style")) {
                Button {
                    locationVM.mapStyle = .standard(elevation: .realistic, pointsOfInterest: .excludingAll)
                    
                } label: {
                    Text("Explore")
                }
                Button {
                    locationVM.mapStyle = .imagery(elevation: .realistic)
                } label: {
                    Text("Satellite")
                }
            }
            
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
                .frame(width: 50, height: 30)
                .shadow(radius: 6, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func hideResults() {
        searchResultsNeeded = false
    }
    
    private func delete(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(favoriteLocations[index])
            }
        }
    }
    
    private func createQuery() {
        // Start a new timer with a 1-second delay
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            // This block will be executed after user stops typing
            DispatchQueue.main.async {
                searchResultsNeeded = true
                weatherVM.query = searchText
                weatherVM.fetchWeatherData()
                
                if let location = weatherVM.weatherData?.location {
                    withAnimation {
                        locationVM.position = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon), distance: 20000, heading: locationVM.heading,  pitch: 60))
                    }
                }
            }
        }
    }
    
    private func updateMap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            locationVM.updateUserLocation()
        }
    }
}
