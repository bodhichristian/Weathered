//
//  Color-Custom.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI

extension Color {
    static let midnightStart = Color(hue: 0.66, saturation: 0.8, brightness: 0.1)
    static let midnightEnd = Color(hue: 0.62, saturation: 0.5, brightness: 0.33)
    static let sunriseStart = Color(hue: 0.62, saturation: 0.6, brightness: 0.42)
    static let sunriseEnd = Color(hue: 0.95, saturation: 0.35, brightness: 0.66)
    static let sunnyDayStart = Color(hue: 0.6, saturation: 0.6, brightness: 0.6)
    static let sunnyDayEnd = Color(hue: 0.6, saturation: 0.4, brightness: 0.85)
    static let sunsetStart = Color.sunriseStart
    static let sunsetEnd = Color(hue: 0.05, saturation: 0.34, brightness: 0.65)
}
