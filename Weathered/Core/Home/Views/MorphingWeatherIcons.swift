//
//  MorphingWeatherIcons.swift
//  Weathered
//
//  Created by christian on 9/17/23.
//

import SwiftUI

struct MorphingWeatherIcons: View {
    @State private var timer: Timer?
    @State private var selectedImage = 0

    var body: some View {
        
            VStack {
                Spacer()
                MorphingImageCL(systemName: WeatherAnimationArray[selectedImage])
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                    .foregroundStyle(.white)
                    .onAppear {
                        startAnimation() // Start a timer that updates `selectedImage` at a set interval
                    }
                Spacer()
                Spacer()
                Spacer()
            }
        }
    
    private func startAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.3, repeats: true) { _ in
            let lastIndex = WeatherAnimationArray.count - 1
            if selectedImage == lastIndex {
                selectedImage = 0
            } else {
                selectedImage += 1
            }
        }
        
    }
}

#Preview {
    MorphingWeatherIcons()
}
