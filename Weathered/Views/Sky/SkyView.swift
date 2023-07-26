//
//  SkyView.swift
//  Weathered
//
//  Created by christian on 7/25/23.
//

import SwiftUI

struct SkyView: View {
    @State private var cloudThickness = Cloud.Thickness.light
    @State private var time = 0.1
    
    @State private var stormType = Storm.Contents.none
    @State private var rainIntensity = 500.0
    @State private var rainAngle = 0.0
    

    
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
        SkyView()
            .preferredColorScheme(.dark)
    }
}