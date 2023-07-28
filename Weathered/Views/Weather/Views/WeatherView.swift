//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI


struct WeatherView: View {
    let weatherData: WeatherData
    
    @Binding var viewingDetails: Bool
    
    @State private var time = 0.1
    
    
    @State private var lightningMaxBolts = 4.0
    @State private var lightningForkProbability = 20.0
    
    @State private var showingControls = false
    
    let residueType =  Storm.Contents.none
    let resiudeStrength = 0.0
    
    var low: Int {
        Int(weatherData.forecast.forecastday[0].day.mintempF)
    }
    
    var high: Int {
        Int(weatherData.forecast.forecastday[0].day.maxtempF)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                SkyView(time: weatherData.location.localtime.calculateTimeOfDay() ?? 0.0)
                
                
                ResidueView(type: residueType, strength: resiudeStrength)
                    .frame(height: 62)
                    .offset(y: -65)
                    .zIndex(1)
                
                
                // Current Weather conditions
                // Extract to sepearate view
                
                VStack(alignment: .center, spacing: 0) {
                    Text(weatherData.location.localtime.getDate())
                        .font(.title3)
                        .fontWeight(.medium)
                        .shadow(radius: 3)
                    
                    Text(weatherData.location.localtime.getTime())
                        .font(.system(size: 70))
                    //.fontDesign(.serif)
                        .fontWeight(.medium)
                    
                    
                    
                    Text(weatherData.location.name)
                        .lineLimit(1)
                        .font(.system(size: 45))
                        .padding(.top, -10)
                    
                    
                    Text(weatherData.location.region)
                        .font(.headline)
                        .opacity(0.8)
                        .padding(.top, 6)
                        .padding(.bottom, 25)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Feels like \(Int(weatherData.current.feelslikeF))° F")
                                .font(.headline)
                            Text(weatherData.current.condition.text)
                            
                            HStack {
                                Text("L \(low)°")
                                
                                Text("H \(high)°")
                            }
                        }
                        Spacer()
                        
                        Text("\(Int(weatherData.current.tempF))°")
                            .font(.system(size: 96))
                            .fontWeight(.ultraLight)
                            .offset( y: -18)
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, -15)
                    
                    WeatherDetailsView(
                        weatherData: weatherData,
                        tintColor: backgroundTopStops.interpolated(amount: time)
                    )
                }
                .padding(.leading, 5)
                .shadow(color: .black.opacity(0.6), radius: 6, y: 4)
                

                
                
                LightningView(maximumBolts: Int(lightningMaxBolts), forkProbability: Int(lightningForkProbability))
                
                
                ZStack(alignment: .topLeading) {
                    VStack {
                        HStack {
                            Button {
                                withAnimation(.spring()) {
                                    viewingDetails = false
                                }
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .shadow(radius: 6, y: 4)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.leading, 30)
                            .padding(.top, 90)
                            Spacer()
                        }
                        Spacer()

                    }
                }
                .ignoresSafeArea()
                
            }
            // This toolbar is currently necessary to keep the alpha layer intentionally empty
            // This is a temporary solution while the weather animation depends on the alpha layer
            // Removing content from this toolbar will result in a WeatherView UI that animates undesireably.
            .toolbar {
                Text("")
            }
            .preferredColorScheme(.dark)
        }
        
    }
    
    // Convert time double into a neatly formatted string
    var formattedTime: String {
        let start = Calendar.current.startOfDay(for: Date.now)
        let advanced = start.addingTimeInterval(time * 24 * 60 * 60)
        return advanced.formatted(date: .omitted, time: .shortened)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(
            weatherData: SampleWeatherData,
            viewingDetails: .constant(true)
            
        )
    }
}





// FOR DEBUG
// Modififer to add controls console

//        .safeAreaInset(edge: .bottom) {
//            VStack {
//                Button {
//                    withAnimation{
//                        showingControls.toggle()
//                    }
//                } label: {
//                    Label("Weather Effects", systemImage: "arrow.up.and.down.and.sparkles")
//                }
//                .padding(8)
//
//                if showingControls {
//                    VStack{
//                        Text(formattedTime)
//                            .font(.title)
//                            .fontWeight(.medium)
//                            .padding(.top)
//
//                        HStack {
//                            Text("Time:")
//
//                            Slider(value: $time)
//                        }
//
//                        HStack {
//                            Text("Cloud Coverage")
//                                .fontWeight(.medium)
//                            Spacer()
//                        }
//                        .padding(4)
//
//                        Picker("Thickness", selection: $cloudThickness) {
//                            ForEach(Cloud.Thickness.allCases, id: \.self) { thickness in
//                                Text(String(describing: thickness).capitalized)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//
//                        HStack {
//                            Text("Precipitation")
//                                .fontWeight(.medium)
//                            Spacer()
//                        }
//                        .padding(4)
//                        Picker("Precipitation", selection: $stormType) {
//                            ForEach(Storm.Contents.allCases, id: \.self) { stormType in
//                                Text(String(describing: stormType).capitalized)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//                        VStack{
//                            HStack {
//                                Text("Intensity")
//                                Slider(value: $rainIntensity, in: 0...1000)
//                            }
//                            .padding(.horizontal)
//
//                            HStack {
//                                Text("Angle:")
//                                Slider(value: $rainAngle, in: 0...90)
//                            }
//                            .padding(.horizontal)
//                        }
//
//                        Divider()
//
//                        HStack {
//                            Text("Lightning")
//                                .fontWeight(.medium)
//                            Spacer()
//                        }
//                        .padding(4)
//
//                        VStack {
//                            HStack {
//                                Text("Max Bolts:")
//                                Slider(value: $lightningMaxBolts, in: 0...10)
//                            }
//                            .padding(.horizontal)
//
//                            HStack {
//                                Text("Fork %:")
//                                Slider(value: $lightningForkProbability, in: 0...100)
//                            }
//                            .padding(.horizontal)
//                        }
//
//                    }
//                    .transition(.move(edge: .bottom))
//                }
//            }
//            .padding(5)
//            .frame(maxWidth: .infinity)
//            .background(.regularMaterial)
//        }
