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
    
    
    var stormType: Storm.Contents {
        switch weatherData.current.condition.code {
            // No precipitation
        case 1000, 1003, 1006, 1009, 1030:
            return .none
            // Description includes'snow'
        case 1066, 1114, 1210, 1213, 1216, 1219, 1222, 1225, 1237, 1279, 1282:
            return .snow
            // Description includes 'rain' or 'sleet'
        default:
            return .rain
        }
    }
    
    
    var stormIntensity: Double {
        switch weatherData.current.condition.code {
            // Description includes 'patchy'
        case 1063, 1066, 1069, 1072, 1150, 1180, 1210, 1222, 1273, 1279:
            return 50.0
            // Description includes 'light'
        case 1153, 1183, 1198, 1204, 1213, 1240, 1249, 1255, 1261:
            return 500.0
            // Description includes 'torrential'
        case 1246:
            return 1500.0
            // Default precipitation amount
        default:
            return 800.0
        }
    }
    
    var time: Double {
        weatherData.location.localtime.calculateTimeOfDay() ?? 0.5
    }
    
    var starOpacity: Double {
        let color = starStops.interpolated(amount: time)
        return color.getComponents().alpha
    }
    
    @State private var precipitationAngle = 0.0
    
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
            
            if stormType != .none { // If a storm type is provided
                StormView(type: stormType, direction: .degrees(precipitationAngle), strength: Int(stormIntensity))
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
        SkyView(weatherData: SampleData.weather)
            .preferredColorScheme(.dark)
    }
}
