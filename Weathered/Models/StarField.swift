//
//  StarField.swift
//  Weathered
//
//  Created by christian on 3/27/23.
//

import Foundation

class StarField {
    var stars = [Star]() // Array to hold Star instances
    let leftEdge = -50.0 // Left edge boundary for stars
    let rightEdge = 500.0 // Right edge boundary for stars
    
    var lastUpdate = Date.now // Keep track of the last render
    
    init() {
        // Initialize stars in the star field
        for _ in 1...200 {
            let x = Double.random(in: leftEdge...rightEdge) // Random x position within left and right edge
            let y = Double.random(in: 0...600) // Random y position within top edge and 600
            let size = Double.random(in: 1...3) // Random size of the star
            let star = Star(x: x, y: y, size: size) // Create a Star instance
            stars.append(star) // Add the star to the stars array
        }
    }
    
    func update(date: Date) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970 // Calculate time elapsed since last update
        
        for star in stars { 
            star.x -= delta * 2 // Update the x position of the star to simulate horizontal movement
            
            if star.x < leftEdge { // If the star goes beyond the left edge
                star.x = rightEdge // Reset its x position to the right edge to create an infinite loop effect
            }
        }
        
        lastUpdate = date // Update the last update time to the current time
    }
}
