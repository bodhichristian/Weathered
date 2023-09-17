//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI


struct ConditionsView: View {
    let weatherData: WeatherData
    let fontDesign: Font.Design
    
    @Binding var viewingDetails: Bool
    
    @State private var time = 0.1
    @State private var lightningMaxBolts = 4.0
    @State private var lightningForkProbability = 20.0
    @State private var showingControls = false
    
    
    let residueType =  Storm.Contents.none
    let resiudeStrength = 0.0
    
    var thunderStorm: Bool {
        switch weatherData.current.condition.code {
        case 1273, 1276, 1279, 1282:
            return true
        default:
            return false
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                SkyView(weatherData: weatherData)
                
                ResidueView(type: residueType, strength: resiudeStrength)
                    .frame(height: 62)
                    .offset(y: -65)
                    .zIndex(1)
                
                // Weather Details
                VStack(alignment: .center, spacing: 0) {
                    PrimaryDetailsView(weatherData: weatherData,
                                       fontDesign: fontDesign)
                    
                    SecondaryDetailsView(
                        weatherData: weatherData,
                        tintColor: backgroundTopStops.interpolated(amount: time)
                    )
                }
                .padding(.leading, 5)
                .shadow(color: .black.opacity(0.6), radius: 6, y: 4)
                
                if thunderStorm{
                    LightningView(maximumBolts: Int(lightningMaxBolts), forkProbability: Int(lightningForkProbability))
                }
                
                backToSearchButton
                
            }
            /*
             This toolbar is currently necessary to keep the alpha layer intentionally empty
             This is a temporary solution while the weather animation depends on the alpha layer
             Removing content from this toolbar will result in a WeatherView UI that animates undesireably.
             */
            .toolbar {
                Text("")
            }
            .preferredColorScheme(.dark)
        }
        
    }
}

struct ConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionsView(
            weatherData: SampleData.weather,
            fontDesign: .default,
            viewingDetails: .constant(true)
        )
    }
}


extension ConditionsView {
    // Magnifying glass button
    private var backToSearchButton: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                HStack {
                    Button {
                            viewingDetails = false
                        
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
}

