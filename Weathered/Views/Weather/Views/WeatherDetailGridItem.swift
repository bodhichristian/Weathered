//
//  WeatherDetailGridItem.swift
//  Weathered
//
//  Created by christian on 7/25/23.
//

import SwiftUI

struct WeatherDetailGridItem: View {
    let metric: String
    let value: String
    let iconName: String
    let color: Color
    
    var frameWidth: Double {
        switch iconName {
        case "sunrise", "sunset":
            return 36
        case "moon.stars", "moon.zzz":
            return 30
        default:
            return 30
        }
    }
    
    var offset: Double {
        switch iconName {
        case "sunset", "sunrise":
            return -3
        default:
            return 0
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.ultraThinMaterial)
                
                VStack {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: frameWidth, height: frameWidth)
                        .foregroundColor(color)
                        .padding(.bottom, 2)
                    Text(value)
                        .font(.caption2)
                        .offset(y: offset)
                }
            }
            
            Text(metric)
                .font(.caption2)
                .shadow(radius: 3)
        }
        
    }
}

struct WeatherDetailGridItem_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailGridItem(metric: "Sunrise", value: "6:26 AM", iconName: "sunrise", color: .yellow)
            
    }
}
