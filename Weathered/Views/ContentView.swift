//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var cloudThickness = Cloud.Thickness.regular
    @State private var time = 0.0
    
    let backgroundTopStops: [Gradient.Stop] = [
        .init(color: .midnightStart, location: 0),
        .init(color: .midnightStart, location: 0.25),
        .init(color: .sunriseStart, location: 0.33),
        .init(color: .sunnyDayStart, location: 0.38),
        .init(color: .sunnyDayStart, location: 0.7),
        .init(color: .sunriseStart, location: 0.78),
        .init(color: .midnightStart, location: 0.82),
        .init(color: .midnightStart, location: 1)
    ]

    let backgroundBottomStops: [Gradient.Stop] = [
        .init(color: .midnightEnd, location: 0),
        .init(color: .midnightEnd, location: 0.25),
        .init(color: .sunriseEnd, location: 0.33),
        .init(color: .sunnyDayEnd, location: 0.38),
        .init(color: .sunnyDayEnd, location: 0.7),
        .init(color: .sunsetEnd, location: 0.78),
        .init(color: .midnightEnd, location: 0.82),
        .init(color: .midnightEnd, location: 1)
    ]
    
    let cloudTopStops: [Gradient.Stop] = [
        .init(color: .darkCloudStart, location: 0),
        .init(color: .darkCloudStart, location: 0.25),
        .init(color: .sunriseCloudStart, location: 0.33),
        .init(color: .lightCloudStart, location: 0.38),
        .init(color: .lightCloudStart, location: 0.7),
        .init(color: .sunsetCloudStart, location: 0.78),
        .init(color: .darkCloudStart, location: 0.82),
        .init(color: .darkCloudStart, location: 1)
    ]

    let cloudBottomStops: [Gradient.Stop] = [
        .init(color: .darkCloudEnd, location: 0),
        .init(color: .darkCloudEnd, location: 0.25),
        .init(color: .sunriseCloudEnd, location: 0.33),
        .init(color: .lightCloudEnd, location: 0.38),
        .init(color: .lightCloudEnd, location: 0.7),
        .init(color: .sunsetCloudEnd, location: 0.78),
        .init(color: .darkCloudEnd, location: 0.82),
        .init(color: .darkCloudEnd, location: 1)
    ]
    
    let starStops: [Gradient.Stop] = [
        .init(color: .white, location: 0),
        .init(color: .white, location: 0.25),
        .init(color: .clear, location: 0.333),
        .init(color: .clear, location: 0.38),
        .init(color: .clear, location: 0.7),
        .init(color: .clear, location: 0.8),
        .init(color: .white, location: 0.85),
        .init(color: .white, location: 1)
    ]
    
    var starOpacity: Double {
        let color = starStops.interpolated(amount: time)
        return color.getComponents().alpha
    }
    
    var body: some View {
        ZStack {
            StarsView()
                .opacity(starOpacity)
            
            CloudsView(
                thickness: cloudThickness,
                topTint: cloudTopStops.interpolated(amount: time),
                bottomTint: cloudBottomStops.interpolated(amount: time)
            )
        }
        .preferredColorScheme(.dark)
        .background(
            LinearGradient(colors: [
                backgroundTopStops.interpolated(amount: time),
                backgroundBottomStops.interpolated(amount: time)
            ], startPoint: .top, endPoint: .bottom)
        )
        .safeAreaInset(edge: .bottom) {
            VStack {
                Text(formattedTime)
                    .padding(.top)
                
                Picker("Thickness", selection: $cloudThickness) {
                    ForEach(Cloud.Thickness.allCases, id: \.self) { thickness in
                        Text(String(describing: thickness).capitalized)
                    }
                }
                .pickerStyle(.segmented)
                
                HStack {
                    Text("Time:")
                    Slider(value: $time)
                }
                .padding()
            }
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
    }
    
    // Convert time double into a neatly formatted string
    var formattedTime: String {
        let start = Calendar.current.startOfDay(for: Date.now)
        let advanced = start.addingTimeInterval(time * 24 * 60 * 60)
        return advanced.formatted(date: .omitted, time: .shortened)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
