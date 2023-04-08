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
    
    var bolts = [LightningBolt]()
    var state = LightningState.waiting
    var lastUpdate = Date.now
    var flashOpacity = 0.0
    
    var maximumBolts: Int
    var forkProbability: Int
    
    init(maximumBolts: Int, forkProbability: Int) {
        self.maximumBolts = maximumBolts
        self.forkProbability = forkProbability
    }
    
    func update(date: Date, in size: CGSize) {
        let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
        lastUpdate = date
        
        switch state {
        case .waiting:
            break
        case .preparing:
            let startPosition = CGPoint(x: Double.random(in: 50...size.width - 50), y: 50)
            let newBolt = LightningBolt(start: startPosition, width: 5, angle: Angle.degrees(270).radians)
            bolts.append(newBolt)
            state = .striking
            
        case .striking:
            let speed = delta * 800
            var hasFinishedStriking = true
            
            for bolt in bolts {
                guard var lastPoint = bolt.points.last else { continue }
                
                for _ in 0..<5 {
                    let endX = lastPoint.x + (speed * cos(bolt.angle) + Double.random(in: -10...10))
                    let endY = lastPoint.y - (speed * sin(bolt.angle) + Double.random(in: -10...10))
                    lastPoint = CGPoint(x: endX, y: endY)
                    bolt.points.append(lastPoint)
                }
                
                if lastPoint.y < size.height {
                    hasFinishedStriking = false
                    
                    if bolts.count < maximumBolts && Int.random(in: 0..<100) < forkProbability {
                        let newAngle = Double.random(in: -.pi / 4 ... .pi / 4 ) - .pi / 2
                        let newBolt = LightningBolt(start: lastPoint, width: bolt.width * 0.75, angle: newAngle)
                        bolts.append(newBolt)
                    }
                }
            }
            
            if hasFinishedStriking {
                state = .fading
                flashOpacity = 0.6
                
                for bolt in bolts {
                    bolt.width *= 1.5
                }
            }
            
        case .fading:
            var allFaded = true
            flashOpacity -= delta
            
            for bolt in bolts {
                bolt.width -= delta * 15
                
                if bolt.width > 0.05 {
                    allFaded = false
                }
            }
            
            if allFaded && flashOpacity <= 0 {
                state = .waiting
                bolts.removeAll(keepingCapacity: true)
            }
        }
    }
    
    func strike() {
        guard state == .waiting else { return }
        state = .preparing
    }
}
