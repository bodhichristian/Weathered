//
//  ResidueDrop.swift
//  Weathered
//
//  Created by christian on 3/30/23.
//

import SwiftUI

class ResidueDrop: Hashable {
    var id = UUID()
    var destructionTime: Double // The time (in seconds) when this ResidueDrop should be removed from the screen.
    var x: Double
    var y = 0.5
    var scale: Double
    var speed: Double
    var opacity: Double
    var xMovement: Double // The amount to move this `ResidueDrop` horizontally each frame.
    var yMovement: Double // The amount to move this `ResidueDrop` vertically each frame.

    
    init(type: Storm.Contents, xPosition: Double, destructionTime: Double) {
        self.x = xPosition
        self.destructionTime = destructionTime
        
        switch type {
        case .snow:
            // For snow, we want smaller particles with lower opacity that don't move much.
            scale = Double.random(in: 0.125...0.75)
            opacity = Double.random(in: 0.2...0.7)
            speed = 0
            xMovement = 0
            yMovement = 0
        default:
            // For rain, we want larger particles with higher opacity that move at a moderate speed.
            scale = Double.random(in: 0.4...0.5)
            opacity = Double.random(in: 0...0.3)
            speed = 2
            
            // Range creates an upward facing 45 degree cone
            let direction = Angle.degrees(.random(in: 225...315)).radians
            xMovement = cos(direction)
            yMovement = sin(direction) / 1.5
        }
    }
    
    /// **HASHABLE CONFORMANCE**
    static func ==(lhs: ResidueDrop, rhs: ResidueDrop) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
