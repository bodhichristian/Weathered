//
//  ColorInterpolation.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI

extension Color {
    
    /// Returns the RGBA values of a `Color` instance.
    ///
    /// - Returns: A tuple of the red, green, blue, and alpha components of the color.
    func getComponents() -> (red: Double, green: Double, blue: Double, alpha: Double) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let uiColor = UIColor(self)
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    
    /// Interpolates between the receiver color and another color by the given amount.
    ///
    ///  - Parameters:
    ///     - other: The other color to interpolate to.
    ///     - amount: The amount of interpolation to perform, between 0.0 and 1.0.
    ///
    ///  - Returns: A new color object created by interpolating between the receiver and `other`.
    ///             The new color is created using the `displayP3` color space to regain lost color depth in the translation.
    func interpolated(to other: Color, amount: Double) -> Color {
        let componentsFrom = self.getComponents()
        let componentsTo = other.getComponents()
        
        let newRed = (1.0 - amount) * componentsFrom.red + (amount * componentsTo.red)
        let newGreen = (1.0 - amount) * componentsFrom.green + (amount * componentsTo.green)
        let newBlue = (1.0 - amount) * componentsFrom.blue + (amount * componentsTo.blue)
        let newOpacity = (1.0 - amount) * componentsFrom.alpha + (amount * componentsTo.alpha)
        
        // Returns a new color object created by interpolating between the receiver and `other`.
        // The new color is created using the `displayP3` to regain lost color depth in the translation
        return Color(.displayP3, red: newRed, green: newGreen, blue: newBlue, opacity: newOpacity)
    }
}
