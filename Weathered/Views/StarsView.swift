//
//  StarView.swift
//  Weathered
//
//  Created by christian on 3/27/23.
//

import SwiftUI

struct StarsView: View {
    @State var starField = StarField()
    
    var body: some View {
        TimelineView(.animation) { timeline in 
            Canvas { context, size in
                let timeInterval = timeline.date.timeIntervalSince1970
                starField.update(date: timeline.date)
                context.addFilter(.blur(radius: 0.3))
                
                for (index, star) in starField.stars.enumerated() {
                    let path = Path(ellipseIn: CGRect(x: star.x, y: star.y, width: star.size, height: star.size))
                    if star.flickerInterval == 0 {
                        // Flashing star
                        var flashLevel = sin(Double(index) + timeInterval * 4)
                        flashLevel = abs(flashLevel)
                        flashLevel /= 2
                        context.opacity = 0.5 + flashLevel
                    } else {
                        // Blooming star
                        var flashLevel = sin(Double(index) + timeInterval)
                        flashLevel *= star.flickerInterval
                        flashLevel -= star.flickerInterval - 1
                        
                        if flashLevel > 0 {
                            var contextCopy = context
                            contextCopy.opacity = flashLevel
                            contextCopy.addFilter(.blur(radius: 3))
                            contextCopy.fill(path, with: .color(white: 1))
                            contextCopy.fill(path, with: .color(white: 1))
                            contextCopy.fill(path, with: .color(white: 1))
                        }
                        
                        context.opacity = 1
                    }
                    if index.isMultiple(of: 5) {
                        context.fill(path, with: .color(red: 1, green: 0.85, blue: 0.8))
                    } else {
                        context.fill(path, with: .color(white: 1))
                    }
                }
            }
        }
        .ignoresSafeArea()
        .mask (
            LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom)
        )
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
