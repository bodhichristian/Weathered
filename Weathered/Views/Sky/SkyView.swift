//
//  SkyView.swift
//  Weathered
//
//  Created by christian on 7/25/23.
//

import SwiftUI

struct SkyView: View {
    let weatherData: WeatherData
    
    
    
    var cloudThickness: Cloud.Thickness {
        switch weatherData.current.condition.code {
        case 1000:
            return .none
        case 1003:
            return .light
        case 1006, 1063, 1066, 1069, 1072, 1150, 1180, 1210, 1216, 1222:
            return .regular
        case 1009, 1153, 1183, 1198, 1213, 1240, 1249, 1255, 1261:
            return .thick
        default:
            return .ultra
        }
        
    }
    
    
    @State private var stormType = Storm.Contents.none
    @State private var rainIntensity = 500.0
    @State private var rainAngle = 0.0
    
    var time: Double {
        weatherData.location.localtime.calculateTimeOfDay() ?? 0.5
    }
    
    var starOpacity: Double {
        let color = starStops.interpolated(amount: time)
        return color.getComponents().alpha
    }
    
    var body: some View {
        ZStack {
            StarsView()
                .opacity(starOpacity)
            
            SunView(progress: time)
            
            CloudsView(
                thickness: cloudThickness,
                topTint: cloudTopStops.interpolated(amount: time),
                bottomTint: cloudBottomStops.interpolated(amount: time)
            )
            
            if stormType != .none{
                StormView(type: stormType, direction: .degrees(rainAngle), strength: Int(rainIntensity))
            }
            
        }
        .background(
            LinearGradient(colors: [
                backgroundTopStops.interpolated(amount: time),
                backgroundBottomStops.interpolated(amount: time)
            ], startPoint: .top, endPoint: .bottom)
        )

    }
}

struct SkyView_Previews: PreviewProvider {
    static var previews: some View {
        SkyView(weatherData: SampleWeatherData)
            .preferredColorScheme(.dark)
    }
}
