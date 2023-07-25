//
//  MeteorShower.swift
//  Weathered
//
//  Created by christian on 4/10/23.
//

import Foundation

class MeteorShower {
    var meteors = Set<Meteor>() // Set to store instances of Meteor representing meteors in the shower
    var lastUpdate = Date.now // Keep track of the last render
    
    var lastCreationDate = Date.now // Date object to store timestamp of last meteor creation
    var nextCreationDelay = Double.random(in: 5...10) // Double value representing time interval until next meteor creation
    
    // Create a new meteor at the edge of the screen
    func createMeteor(in size: CGSize) {
        let meteor: Meteor // Declare a Meteor object
        
        // Randomly decide whether meteor should start from left or right side of the screen
        if Bool.random() {
            meteor = Meteor(x: 0, y: Double.random(in: 100...200), isMovingRight: true)
        } else {
            meteor = Meteor(x: size.width, y: Double.random(in: 100...200), isMovingRight: false)
        }
        
        meteors.insert(meteor) // Add the meteor to the meteors Set
        lastCreationDate = .now // Update lastCreationDate with current timestamp
        nextCreationDelay = Double.random(in: 4...9) // Randomly set nextCreationDelay for next meteor creation
    }
    
    // Method to update positions and properties of meteors in the shower
    func update(date: Date, size: CGSize) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970 // Calculate time interval between current update and last update
        
        // Check if it's time to create a new meteor based on lastCreationDate and nextCreationDelay
        if lastCreationDate + nextCreationDelay < .now {
            createMeteor(in: size) // Call createMeteor method to create a new meteor
        }
        
        // Update positions and properties of meteors based on elapsed time since last update
        for meteor in meteors {
            if meteor.isMovingRight {
                meteor.x += delta * meteor.speed // Update x position of meteor moving to the right
            } else{
                meteor.x -= delta * meteor.speed // Update x position of meteor moving to the left
            }
            
            meteor.speed -= delta * 900 // Update speed of meteor to slow it down over time
            
            if meteor.speed < 0 {
                meteors.remove(meteor) // Remove meteor from Set if speed becomes less than 0
            } else if meteor.length < 100 {
                meteor.length += delta * 300 // Increase length of meteor over time
            }
        }
        
        lastUpdate = date // Update lastUpdate with current timestamp
    }
}
