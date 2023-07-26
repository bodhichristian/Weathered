//
//  CloudsView.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI

struct CloudsView: View {
    var cloudGroup: CloudGroup
    let topTint: Color
    let bottomTint: Color
    
    var body: some View {
        // Redraws constantly
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                context.opacity = cloudGroup.opacity
                cloudGroup.update(date: timeline.date)
                
                // Return an array of all 8 resolved cloud images
                let resolvedImages = (0..<8).map { i -> GraphicsContext.ResolvedImage in
                    let sourceImage = Image("cloud\(i)")
                    var resolved = context.resolve(sourceImage)
                    
                    // Make a linear gradient from the top of the image to the full height of the clouds
                    resolved.shading = .linearGradient(
                        Gradient(colors: [topTint, bottomTint]),
                        startPoint: .zero, endPoint: CGPoint(x: 0, y: resolved.size.height))
                    return resolved
                }
                
                for cloud in cloudGroup.clouds {
                    context.translateBy(x: cloud.position.x, y: cloud.position.y)
                    context.scaleBy(x: cloud.scale, y: cloud.scale)
                    context.draw(resolvedImages[cloud.imageNumber], at: .zero, anchor: .topLeading)
                    context.transform = .identity
                }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    init(thickness: Cloud.Thickness, topTint: Color, bottomTint: Color) {
        cloudGroup = CloudGroup(thickness: thickness)
        self.topTint = topTint
        self.bottomTint = bottomTint
    }
}

struct CloudsView_Previews: PreviewProvider {
    static var previews: some View {
        CloudsView(thickness: .thick, topTint: .white, bottomTint: .white)
            .background(.blue)
    }
}
