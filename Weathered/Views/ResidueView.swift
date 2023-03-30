//
//  ResidueView.swift
//  Weathered
//
//  Created by christian on 3/30/23.
//

import SwiftUI

struct ResidueView: View {
    let residue: Residue
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                residue.update(date: timeline.date, size: size)
                
                for drop in residue.drops {
                    var contextCopy = context
                    
                    let xPos = drop.x * size.width
                    let yPos = drop.y * size.height
                    
                    contextCopy.opacity = drop.opacity
                    contextCopy.translateBy(x: xPos, y: yPos)
                    contextCopy.scaleBy(x: drop.scale, y: drop.scale)
                    contextCopy.draw(residue.image, at: .zero)
                }
            }
        }
    }
    
    init(type: Storm.Contents, strength: Double) {
        residue = Residue(type: type, strength: strength)
    }
}

struct ResidueView_Previews: PreviewProvider {
    static var previews: some View {
        ResidueView(type: .rain, strength: 200)
    }
}
