//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI


struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    @State private var cloudThickness = Cloud.Thickness.thick
    @State private var time = 0.1
    
    @State private var stormType = Storm.Contents.none
    @State private var rainIntensity = 500.0
    @State private var rainAngle = 0.0
    
    @State private var lightningMaxBolts = 4.0
    @State private var lightningForkProbability = 20.0
    
    @State private var showingControls = false
    
    var low: Int {
        Int(viewModel.weatherData?.forecast.forecastday[0].day.mintempF ?? 0)
    }
    
    var high: Int {
        Int(viewModel.weatherData?.forecast.forecastday[0].day.maxtempF ?? 0)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                SkyView()
                
                WeatherDetailsView(
                    weatherData: viewModel.weatherData,
                    tintColor: backgroundTopStops.interpolated(amount: time),
                    residueType: stormType,
                    resiudeStrength: rainIntensity
                )
                
                // Current Weather conditions
                // Extract to sepearate view
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.weatherData?.location.name ?? "")
                            .lineLimit(1)
                            .font(.largeTitle)
                            .fontWeight(.medium)
                        
                        Text(viewModel.weatherData?.current.condition.text ?? "")
                        
                        HStack {
                            Text("L \(low)°")
                            
                            Text("H \(high)°")
                            
                        }
                        
                    }
                    .shadow(color: .black, radius: 7)
                    .padding(20)
                    
                    
                    Spacer()
                    
                    Text("\(Int(viewModel.weatherData?.current.tempF ?? 0))°")
                        .font(.system(size: 96))
                        .fontWeight(.ultraLight)
                        .shadow(color: .black, radius: 7)
                    
                }
                .offset(y: -130)
                .padding()
                
                
                
                
                
                VStack {
                    Text(viewModel.weatherData?.location.localtime.getTime() ?? "")
                        .font(.system(size: 70))
                        //.fontDesign(.serif)
                        .fontWeight(.medium)
                        .padding(.top, 15)
                    
                    Text(viewModel.weatherData?.location.region ?? "")
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 1)
                    
                    Text(viewModel.weatherData?.location.localtime.getDate() ?? "")
                        .font(.title)
                    Spacer()
                }
                .shadow(radius: 6)
                
                
                
                
                LightningView(maximumBolts: Int(lightningMaxBolts), forkProbability: Int(lightningForkProbability))
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        viewModel.query = "Lake_Grove"
                        viewModel.fetchWeatherData()
                    } label: {
                        Text("Search")
                    }
                }
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
        WeatherView()
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
