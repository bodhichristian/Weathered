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
    @Binding var fontDesign: Font.Design
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.midnightStart, .midnightEnd], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            

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
            .offset(y: -120)
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
            
            ZStack(alignment: .topTrailing) {
                VStack {
                    Spacer()
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
                    
                }
            }
            
        }
        .onChange(of: searchText) { query in
            // Invalidate the previous timer when the user types again
            timer?.invalidate()
            
            // Start a new timer with a 2-second delay
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                // This block will be executed 1 second after user stops typing
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
        SearchView(viewingDetails: .constant(false), fontDesign: .constant(.default))
            .environmentObject(WeatherViewModel())
    }
}
