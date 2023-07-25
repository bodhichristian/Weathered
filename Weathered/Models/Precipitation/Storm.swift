//
//  Storm.swift
//  Weathered
//
//  Created by christian on 3/27/23.
//

import SwiftUI

class Storm {
    enum Contents: CaseIterable { // Precipitation type
        case none, rain, snow
    }
    
    var drops = [StormDrop]() // Array to hold instances of StormDrop, representing the individual drops in the storm
    var lastUpdate = Date.now // Keep track of the last render
    var image: Image? // An optional rain drop or snow flake image
    
    init(type: Contents, direction: Angle, strength: Int) {
        // Load correct image based on storm type
        switch type {
        case .snow:
            image = Image("snow")
        default:
            image = Image("rain")
        }
        // Create Storm Drop instances based on storm strength
        for _ in 0..<strength {
            drops.append(StormDrop(type: type, direction: direction + .degrees(90)))
        }
    }
    
    func update(date: Date, size: CGSize) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970 // Calculate the time interval since the last update
        
        let divisor = size.height / size.width // Calculate a divisor based on the size of the storm
        
        for drop in drops {
            let radians = drop.direction.radians // Convert the direction of the drop from degrees to radians
            drop.x += cos(radians) * drop.speed * delta * divisor // Update the x-coordinate of the drop based on its current direction, speed, time interval, and size
            drop.y += sin(radians) * drop.speed * delta // Update the y-coordinate of the drop based on its current direction, speed, and time interval
            
            if drop.x < -0.2 { // If the drop has moved outside the visible area on the left side
                drop.x += 1.4 // Wrap the drop to the right side of the screen
            }
            
            if drop.y > 1.2 { // If the drop has moved outside the visible area on the bottom side
                drop.x = Double.random(in: -0.2...1.2) // Randomly reposition the drop within the visible area on the x-axis
                drop.y -= 1.4 // Wrap the drop to the top side of the screen
            }
            
            drop.rotation += drop.rotationSpeed * delta // Update the rotation of the drop based on its current rotation speed and time interval
        }
        
        lastUpdate = date // Updating the last update time to the current time
    }
}
