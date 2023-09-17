//
//  LightningView.swift
//  Weathered
//
//  Created by christian on 4/8/23.
//

import SwiftUI

struct LightningView: View {
    var lightning: Lightning
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                lightning.update(date: timeline.date, in: size)
                
                let fullScreen = Path(CGRect(origin: .zero, size: size))
                context.fill(fullScreen, with: .color(.white.opacity(lightning.flashOpacity)))
                
                for _ in 0..<2 {
                    for bolt in lightning.bolts {
                        var path = Path()
                        path.addLines(bolt.points)
                        context.stroke(path, with: .color(.white), lineWidth: bolt.width)
                    }
                    
                    context.addFilter(.blur(radius: 5))
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            lightning.strike()
        }
        .onTapGesture {
            lightning.strike()
        }
    }
    
    init(maximumBolts: Int = 4, forkProbability: Int = 20) {
        lightning = Lightning(maximumBolts: maximumBolts, forkProbability: forkProbability)
    }
}

struct LightningView_Previews: PreviewProvider {
    static var previews: some View {
        LightningView()
    }
}
