//
//  GradientStops.swift
//  Weathered
//
//  Created by christian on 7/25/23.
//

import Foundation
import SwiftUI

let backgroundTopStops: [Gradient.Stop] = [
    .init(color: .midnightStart, location: 0),
    .init(color: .midnightStart, location: 0.25),
    .init(color: .sunriseStart, location: 0.33),
    .init(color: .sunnyDayStart, location: 0.38),
    .init(color: .sunnyDayStart, location: 0.7),
    .init(color: .sunriseStart, location: 0.78),
    .init(color: .midnightStart, location: 0.82),
    .init(color: .midnightStart, location: 1)
]

let backgroundBottomStops: [Gradient.Stop] = [
    .init(color: .midnightEnd, location: 0),
    .init(color: .midnightEnd, location: 0.25),
    .init(color: .sunriseEnd, location: 0.33),
    .init(color: .sunnyDayEnd, location: 0.38),
    .init(color: .sunnyDayEnd, location: 0.7),
    .init(color: .sunsetEnd, location: 0.78),
    .init(color: .midnightEnd, location: 0.82),
    .init(color: .midnightEnd, location: 1)
]

let cloudTopStops: [Gradient.Stop] = [
    .init(color: .darkCloudStart, location: 0),
    .init(color: .darkCloudStart, location: 0.25),
    .init(color: .sunriseCloudStart, location: 0.33),
    .init(color: .lightCloudStart, location: 0.38),
    .init(color: .lightCloudStart, location: 0.7),
    .init(color: .sunsetCloudStart, location: 0.78),
    .init(color: .darkCloudStart, location: 0.82),
    .init(color: .darkCloudStart, location: 1)
]

let cloudBottomStops: [Gradient.Stop] = [
    .init(color: .darkCloudEnd, location: 0),
    .init(color: .darkCloudEnd, location: 0.25),
    .init(color: .sunriseCloudEnd, location: 0.33),
    .init(color: .lightCloudEnd, location: 0.38),
    .init(color: .lightCloudEnd, location: 0.7),
    .init(color: .sunsetCloudEnd, location: 0.78),
    .init(color: .darkCloudEnd, location: 0.82),
    .init(color: .darkCloudEnd, location: 1)
]

let starStops: [Gradient.Stop] = [
    .init(color: .white, location: 0),
    .init(color: .white, location: 0.25),
    .init(color: .clear, location: 0.333),
    .init(color: .clear, location: 0.38),
    .init(color: .clear, location: 0.7),
    .init(color: .clear, location: 0.8),
    .init(color: .white, location: 0.85),
    .init(color: .white, location: 1)
]
