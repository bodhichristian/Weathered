//
//  Residue.swift
//  Weathered
//
//  Created by christian on 3/30/23.
//

import SwiftUI

class Residue {
    var drops = Set<ResidueDrop>()
    var lastUpdate = Date.now
    var nextCreationTime = Date.now
    
    let image = Image("snow")
    let type: Storm.Contents
    
    let creationAmount: Int // Number of drops to create
    let lifetime: ClosedRange<Double> // The range of time a ResidueDrop should last
    let creationDelay: ClosedRange<Double>? // The range of time to wait before creating new ResidueDrop objects
    
    init(type: Storm.Contents, strength: Double) {
        self.type = type
        
        switch type { // Set creationAmount and lifetime based on storm contents
        case .snow: // Create one residue element
            creationAmount = 1
            lifetime = 1.0...2.0
        default: // Create three resiude elements
            creationAmount = 3
            lifetime = 0.9...1.1
        }
        
        // Set creationDelay based on the storm's strength
        if type == .none || strength == 0 {
            creationDelay = nil
        } else {
            switch strength {
            case 1...200:
                creationDelay = 0...0.25
            case 201...400:
                creationDelay = 0...0.1
            case 401...800:
                creationDelay = 0...0.05
            default:
                creationDelay = 0...0.02
            }
        }
}
    
    // Update the state of the residue
    func update(date: Date, size: CGSize) {
        // If there is no creationDelay, return
        guard let creationDelay = creationDelay else { return }
        
        // Calculate the time delta since the last update
        let currentTime = date.timeIntervalSince1970
        let delta = currentTime - lastUpdate.timeIntervalSince1970
        // Calculate the yMovement divisor based on the size of the scene
        let divisor = size.height / size.width
        
        // Update the position of each ResidueDrop
        for drop in drops {
            // Move the drop according to its x and y movement, speed, and the time delta
            drop.x += drop.xMovement * drop.speed * delta * divisor
            drop.y += drop.yMovement * drop.speed * delta
            
            // Increase the yMovement by 2 times the delta, simulating gravity
            drop.yMovement += delta * 2
            
            // If falling below 'ground level', check if it should stop
            if drop.y > 0.5 {
                // If drop is in range, reset y and yMovement
                if drop.x > 0.075 && drop.x < 0.925 {
                    drop.y = 0.5
                    drop.yMovement = 0
                }
            }
            
            // Remove drops that have exceeded their destructionTime
            if drop.destructionTime < currentTime {
                drops.remove(drop)
            }
        }
        
        // If the currentTime has exceeded the nextCreationTime
        if nextCreationTime.timeIntervalSince1970 < currentTime {
            // Generate a random x position for the new drops
            let dropX = Double.random(in: 0.075...0.925)
            
            // Create new drops, and add to set
            for _ in 0..<creationAmount {
                drops.insert(ResidueDrop(type: type, xPosition: dropX, destructionTime: currentTime + .random(in: lifetime)))
            }
            
            // Update nextCreationTime to a random value within the creationDelay
            nextCreationTime = Date.now + Double.random(in: creationDelay)
        }
        
        // Update lastUpdate to the current date for the next loop iteration
        lastUpdate = date
    }
}
