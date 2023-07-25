//
//  WeatherDetailsView.swift
//  Weathered
//
//  Created by christian on 3/30/23.
//

import SwiftUI

struct WeatherDetailsView: View {
    // Background color
    let tintColor: Color
    
    let residueType: Storm.Contents
    let resiudeStrength: Double
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ResidueView(type: residueType, strength: resiudeStrength)
                .frame(height: 62)
                .offset(y: 230)
                .zIndex(1)
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(tintColor.opacity(0.25))
                    .frame(height: 400)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 20)
                
                ScrollView {
                    VStack(spacing: 4) {
                        WeatherDetailItem(metric: "Feels like", unit: "°F", value: 81, iconName: "person.fill")
                        WeatherDetailItem(metric: "Humidity", unit: "%",  value: 77, iconName: "humidity.fill")
                        WeatherDetailItem(metric: "Wind", unit: "mph", value: 11, iconName: "wind")
                        WeatherDetailItem(metric: "Visibility", unit: "mi", value: 4, iconName: "eye.fill")
                        WeatherDetailItem(metric: "UV Index", unit: "", value: 4, iconName: "sun.max.fill")
                    }
                    .padding([.leading, .top], 20)
                    .padding(.trailing, 10)
                    
                }
            }
            .padding(.top, 200)
        }
    }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(tintColor: .blue, residueType: .rain, resiudeStrength: 200)
    }
}
