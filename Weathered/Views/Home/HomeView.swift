//
//  SearchView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI
import MapKit
import SwiftData
import ImageMorphing

struct HomeView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \FavoriteLocation.name, order: .forward, animation: .smooth) var favoriteLocations: [FavoriteLocation]
    
    @Binding var viewingDetails: Bool
    @Binding var fontDesign: Font.Design
    
    @StateObject var locationManager = LocationManager()
    @State private var userLocationKnown = false
    
    @State private var searchText = ""
    @State private var locationName: String?
    
    @State private var selectedImage = 0
    @State private var animationTimer: Timer?
    @State private var searchTimer: Timer?
    
    @State private var isSearching = false
    @State private var searchResultsNeeded = false
 
    @State private var position: MapCameraPosition = .automatic
    @State private var heading: Double = 0.0
    @State private var mapStyle: MapStyle = .imagery(elevation: .realistic)
    
   
    
    private var locationIsFavorite: Bool {
        favoriteLocations.contains { $0.name == viewModel.weatherData?.location.name ?? searchText }
    }
    
    
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Map(position: $position)
                    .mapStyle(mapStyle)
                    .ignoresSafeArea()
                
                
                // Background Gradient
                LinearGradient(colors: [.midnightEnd, .midnightStart], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .opacity(0.9)
                
                VStack {
                    // If location is not available
                    if !userLocationKnown {
                        Spacer()
                        MorphingImageCL(systemName: WeatherAnimationArray[selectedImage])
                            .frame(width: 200, height: 200)
                            .padding(.top, 20)
                            .foregroundStyle(.white)
                            .offset(y: isSearching ? -60 : 0)
                            .onAppear {
                                startAnimation() // Start a timer that updates `selectedImage` at a set interval
                            }
                        Spacer()
                        Spacer()
                        Spacer()
                    } else {
                        if userLocationKnown && searchResultsNeeded {
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
                    VStack {
                        Spacer()
                        
                        if viewModel.weatherData == nil {
                            if let currentLocation = locationManager.manager?.location?.coordinate {
                                let location = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                                
                                CurrentLocationView(currentLocation: location, fontDesign: fontDesign)
                                    .padding(.bottom, 20)
                                    .offset(y: isSearching ? 1000 : 0)
                            }
                        }
                        
                        
                        favoriteLocationsView // Visible if user has added a favorite location
                        toolBarView // Search and Settings
                    }
                
            }
            .onChange(of: searchText) {
                searchResultsNeeded = true
                // Start a new timer with a 1-second delay
                searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                    // This block will be executed after user stops typing
                    DispatchQueue.main.async {
                        viewModel.query = searchText
                        viewModel.fetchWeatherData()
                        
                        if let location = viewModel.weatherData?.location {
                            withAnimation {
                                position = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon), distance: 20000, heading: heading,  pitch: 60))
                            }
                        }
                    }
                }
                
                
            }
            .onAppear {
                locationManager.checkIfLocationServicesIsEnabled()
                if let userLocation = locationManager.manager?.location {
                    userLocationKnown = true
                    position = .camera(MapCamera(centerCoordinate: userLocation.coordinate, distance: 20000, heading: heading, pitch: 60))
                }
                
                
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
            Text("\(Int(viewModel.weatherData?.current.tempF ?? 0))°")
                .font(.system(size: 100))
                .foregroundStyle(.white)
                .fontDesign(fontDesign)
            
            
            Text(viewModel.weatherData?.location.name.prefix(25) ?? "")
                .font(.largeTitle)
                .fontDesign(fontDesign)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .lineLimit(1)
            
            Text(viewModel.weatherData?.location.region ?? "")
                .font(.title2)
                .foregroundColor(.lightCloudEnd)
                .lineLimit(1)
        }
        .onTapGesture {
            withAnimation(.spring()){
                if isSearching {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                viewingDetails = true
            }
        }
    }
    
    private var addToFavoritesView: some View {
        Button {
            if let weatherData = viewModel.weatherData {
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
                        viewModel.weatherData = nil
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
                    mapStyle = .standard(elevation: .realistic, pointsOfInterest: .excludingAll)
                    
                } label: {
                    Text("Explore")
                }
                Button {
                    mapStyle = .imagery(elevation: .realistic)
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
    
    private func startAnimation() {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.3, repeats: true) { _ in
            let lastIndex = WeatherAnimationArray.count - 1
            if selectedImage == lastIndex {
                selectedImage = 0
            } else {
                selectedImage += 1
            }
        }
    }
    
}
