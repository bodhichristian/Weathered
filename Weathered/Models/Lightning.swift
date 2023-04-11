//
//  Lightning.swift
//  Weathered
//
//  Created by christian on 4/8/23.
//

import SwiftUI

class Lightning {
    enum LightningState {
        case waiting, preparing, striking, fading
    }
    
    var bolts = [LightningBolt]() // Array to hold lightning bolts
    var state = LightningState.waiting // Current lightning state
    var lastUpdate = Date.now // Last update timestamp for delta time calculation
    var flashOpacity = 0.0 // Opacity of the lightning flash
    
    var maximumBolts: Int // Maximum number of bolts allowed
    var forkProbability: Int // Probability of forking a new bolt
    
    init(maximumBolts: Int, forkProbability: Int) {
        self.maximumBolts = maximumBolts
        self.forkProbability = forkProbability
    }
    
    // Update the lightning state and position
    func update(date: Date, in size: CGSize) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970 // Calculate time since last update
        lastUpdate = date // Update last update timestamp
        
        switch state {
        case .waiting:
            break // Do nothing if waiting
            
        case .preparing:
            let startPosition = CGPoint(x: Double.random(in: 50...size.width - 50), y: 50) // Generate random start position at the top of the screen
            let newBolt = LightningBolt(start: startPosition, width: 5, angle: Angle.degrees(270).radians) // Create a new lightning bolt with the start position, width, and angle
            bolts.append(newBolt) // Add the new bolt to the bolts array
            state = .striking // Transition to striking state
            
        case .striking:
            let speed = delta * 800 // Calculate the speed of the lightning bolt
            var hasFinishedStriking = true // Flag to track if all bolts have finished striking
            
            for bolt in bolts {
                guard var lastPoint = bolt.points.last else { continue } // Get the last point of the bolt
                
                for _ in 0..<5 {
                    let endX = lastPoint.x + (speed * cos(bolt.angle) + Double.random(in: -10...10)) // Calculate the end point x-coordinate with some randomness
                    let endY = lastPoint.y - (speed * sin(bolt.angle) + Double.random(in: -10...10)) // Calculate the end point y-coordinate with some randomness
                    lastPoint = CGPoint(x: endX, y: endY) // Create a new point with the calculated coordinates
                    bolt.points.append(lastPoint) // Add the new point to the bolt's points array
                }
                
                if lastPoint.y < size.height { // If bolt has not hit the bottom of the screen
                    hasFinishedStriking = false
                    
                    if bolts.count < maximumBolts && Int.random(in: 0..<100) < forkProbability { // Check if the maximum number of bolts has not been reached and probability condition is met
                        let newAngle = Double.random(in: -.pi / 4 ... .pi / 4 ) - .pi / 2 // Generate a new angle for forking the bolt
                        let newBolt = LightningBolt(start: lastPoint, width: bolt.width * 0.75, angle: newAngle) // Create a new bolt with the last point as the start position, reduced width, and new angle
                        bolts.append(newBolt) // Add the new bolt to the bolts array
                    }
                }
            }
            
            // If lightning has completed
            if hasFinishedStriking {
                // Transition to fading state
                state = .fading
                flashOpacity = 0.6
                
                // Create 50% larger bolts to flash 
                for bolt in bolts {
                    bolt.width *= 1.5
                }
            }
            
        case .fading:
            var allFaded = true
            flashOpacity -= delta
            
            // Update the width of each bolt based on delta
            // multiplied by a constant factor of 15
            for bolt in bolts {
                bolt.width -= delta * 15
                
                // Check if the width of the bolt is greater than 0.05,
                // if so, set allFaded to false, indicating that not all bolts have faded
                if bolt.width > 0.05 {
                    allFaded = false
                }
            }
            
            // Check if all bolts have faded and flashOpacity has decreased to 0 or below
            if allFaded && flashOpacity <= 0 {
                // If so, set the state to .waiting
                state = .waiting
                // Remove all bolts from the bolts array while keeping the capacity
                bolts.removeAll(keepingCapacity: true)
            }
        }
    }
    
    // Initiate a lightning strike
    func strike() {
        // Check if the state is .waiting, if not, return early and do nothing
        guard state == .waiting else { return }
        // Set the state to .preparing to begin the lightning strike
        state = .preparing
    }
}
