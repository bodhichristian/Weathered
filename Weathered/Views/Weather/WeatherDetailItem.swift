//
//  WeatherDetailItem.swift
//  Weathered
//
//  Created by christian on 7/24/23.
//

import SwiftUI

struct WeatherDetailItem: View {
    let metric: String
    let unit: String
    let value: Int
    let iconName: String
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .padding(.trailing, 10)
                    .fontWeight(.light)
                    .opacity(0.8)
                
                Text(metric)
                    .font(.headline)
                    .fontWeight(.light)
                
                Spacer()
                
                HStack (alignment: .bottom, spacing: 8){
                    Text(String(value))
                        .font(.headline)
                        .fontWeight(.medium)
                    
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: 42, height: 20)
                        .overlay {
                        HStack {
                            Text(unit)
                                .fontWeight(.light)
                                .opacity(0.8)

                            Spacer()

                        }
                    }
                        
                }
                
                
            }
            .fontWeight(.light)
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.white.opacity(0.1))
                .padding(.leading, 46)
                .padding(.trailing, 70)
        }
        .padding(.leading, 4)
    }
}

struct WeatherDetailItem_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailItem(metric: "Humidity", unit: "mph", value: 77, iconName: "humidity")
    }
}
