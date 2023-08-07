//
//  SearchView.swift
//  Weathered
//
//  Created by christian on 7/26/23.
//

import SwiftUI
import ImageMorphing

struct SearchView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    
    @State private var searchText = ""
    @State private var locationName: String?
    @State private var timer: Timer?
    
    @Binding var viewingDetails: Bool
    @Binding var fontDesign: Font.Design
    
    @State private var selectedImage = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.midnightStart, .midnightEnd], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            
            ZStack {
                if viewModel.weatherData == nil {
                    MorphingImage(systemName: SFSymbolsWeatherIcons[selectedImage])
                        .frame(width: 150, height: 150)
                        .foregroundColor(.white)
                        .onAppear {
                            startAnimation()
                        }
                }
                
                VStack {
                    if let location = viewModel.weatherData?.location {
                        HStack(spacing: 0){
                            Text("°")
                                .foregroundColor(.clear)
                                .fontDesign(fontDesign)
                            
                            
                            Text("\(Int(viewModel.weatherData?.current.tempF ?? 0))°")
                                .font(.system(size: 80))
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
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()){
                        viewingDetails = true
                    }
            }
            
            }
            
            

            
            
            ZStack(alignment: .topTrailing) {
                VStack {
                    
                    HStack {
                        Spacer()
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
                                        .fontDesign(.monospaced)
                                }
                                
                                Button {
                                    fontDesign = .serif
                                } label: {
                                    Text("Serif")
                                        .fontDesign(.serif)
                                }
                                
                                Button {
                                    fontDesign = .rounded
                                } label: {
                                    Text("Rounded")
                                        .fontDesign(.rounded)
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
                        .padding(.trailing, 30)
                    }
                    Spacer()
                    
                    // Search Field
                    ZStack {
                        Capsule()
                            .foregroundStyle(.thinMaterial)
                            .frame(width: 350, height: 40)
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search for a location", text: $searchText)
                            
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 350, height: 40)
                    }
                    .padding()
                }
            }
            
        }
        .onChange(of: searchText) { query in
            // Invalidate the previous timer when the user types again
            timer?.invalidate()
            
            // Start a new timer with a 0.5-second delay
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                // This block will be executed  after user stops typing
                DispatchQueue.main.async {
                    viewModel.query = query
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewingDetails: .constant(false), fontDesign: .constant(.default))
            .environmentObject(WeatherViewModel())
    }
}
