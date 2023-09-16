//
//  StormView.swift
//  Weathered
//
//  Created by christian on 3/27/23.
//

import SwiftUI

struct StormView: View {
    let storm: Storm
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                storm.update(date: timeline.date, size: size)
                
                for drop in storm.drops {
                    var contextCopy = context
                    
                    let xPosition = drop.x * size.width
                    let yPosition = drop.y * size.height
                    
                    contextCopy.opacity = drop.opacity
                    contextCopy.translateBy(x: xPosition, y: yPosition)
                    contextCopy.rotate(by: drop.direction + drop.rotation)
                    contextCopy.scaleBy(x: drop.xScale, y: drop.yScale)
                    contextCopy.draw(storm.image ?? Image("empty"), at: .zero)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    init(type: Storm.Contents, direction: Angle, strength: Int) {
        storm = Storm(type: type, direction: direction, strength: strength)
    }
}

struct StormView_Previews: PreviewProvider {
    static var previews: some View {
        StormView(type: .rain, direction: .zero, strength: 200)
    }
}
