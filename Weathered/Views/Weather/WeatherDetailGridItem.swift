//
//  WeatherDetailGridItem.swift
//  Weathered
//
//  Created by christian on 7/25/23.
//

import SwiftUI

struct WeatherDetailGridItem: View {
    let value: String
    let iconName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 70, height: 70)
                .foregroundStyle(.ultraThinMaterial)
            
            VStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.bottom, 2)
                Text(value)
                    .font(.caption2)
            }
        }
        
    }
}

struct WeatherDetailGridItem_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailGridItem(value: "6:26 AM", iconName: "sunrise")
    }
}
