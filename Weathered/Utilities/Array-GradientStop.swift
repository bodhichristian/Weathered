//
//  Array-GradientStop.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI

/// An extension on `Array` that provides a method for interpolating colors between gradient stops.
///
/// - Note: This extension assumes that the array contains `Gradient.Stop` elements. It provides a
///         method to interpolate between the color of the gradient stop that is immediately before
///         the given `amount` and the color of the gradient stop that is immediately after it.

extension Array where Element == Gradient.Stop {
    
    /// Interpolates between the colors of the two gradient stops that straddle the given amount.
    ///
    /// - Parameters:
    ///     - amount: The position between the gradient stops to interpolate, as a value between 0.0 and 1.0.
    ///
    /// - Returns: The interpolated color between the two gradient stops.
    ///
    /// - Note: The interpolation is performed by linearly combining the colors of the two gradient stops.
    ///         If the given `amount` is less than the location of the first gradient stop, the color of
    ///         the first stop is returned. If the given `amount` is greater than the location of the
    ///         last gradient stop, the color of the last stop is returned. If the array contains no
    ///         gradient stops, a fatal error is raised.
    func interpolated(amount: Double) -> Color {
        // If the array is empty, throw a fatal error
        guard let initialStop = self.first else {
            fatalError("Attempt to read color from empty stop array")
        }
        
        // Initialize stops
        var firstStop = initialStop
        var secondStop = initialStop
        
        // Find the gradient stops that straddle the given amount
        for stop in self {
            if stop.location < amount {
                firstStop = stop
            } else {
                secondStop = stop
                break
            }
        }
        
        // Calculate the total difference in location between the two stops
        let totalDifference = secondStop.location - firstStop.location
        
        // If there is a non-zero difference in location, interoplate between the two colors
        if totalDifference > 0 {
            let relativeDifference = (amount - firstStop.location) / totalDifference
            return firstStop.color.interpolated(to: secondStop.color, amount: relativeDifference)
        } else {
            // If the two stops are at the same location, return the color of the first stop
            return firstStop.color.interpolated(to: secondStop.color, amount: 0)
        }
    }
}
