//
//  SampleWeatherData.swift
//  Weathered
//
//  Created by christian on 7/27/23.
//

import Foundation

struct SampleData {
    
    static let favoriteLocation = FavoriteLocation(
        name: "New York City",
        region: "New York",
        country: "United States",
        latitude: 0.0,
        longitude: 0.0
    )
    
    static let weather = WeatherData(
        location: Location(
            name: "New York City",
            region: "New York",
            country: "United States",
            lat: 40.7128,
            lon: -74.0060,
            tzID: "America/New_York",
            localtimeEpoch: 1679846400,
            localtime: "2023-07-27 09:00"
        ),
        current: Current(
            lastUpdatedEpoch: 1679844000,
            lastUpdated: "2023-07-27 08:20",
            tempC: 25.5,
            tempF: 77.9,
            isDay: 1,
            condition: Condition(
                text: "Partly cloudy",
                icon: "https://example.com/icons/partly_cloudy.png",
                code: 1003
            ),
            windMph: 5.8,
            windKph: 9.3,
            windDegree: 120,
            windDir: "ESE",
            pressureMB: 1016.7,
            pressureIn: 30.03,
            precipMm: 0.0,
            precipIn: 0.0,
            humidity: 60,
            cloud: 30,
            feelslikeC: 26.0,
            feelslikeF: 78.8,
            visKM: 10.0,
            visMiles: 6.2,
            uv: 5.0,
            gustMph: 8.5,
            gustKph: 13.7
        ),
        forecast: Forecast(
            forecastday: [
                Forecastday(
                    date: "2023-07-27",
                    dateEpoch: 1679846400,
                    day: Day(
                        maxtempC: 29.0,
                        maxtempF: 84.2,
                        mintempC: 22.0,
                        mintempF: 71.6,
                        avgtempC: 25.5,
                        avgtempF: 77.9,
                        maxwindMph: 10.3,
                        maxwindKph: 16.6,
                        totalprecipMm: 0.0,
                        totalprecipIn: 0.0,
                        totalsnowCM: 0.0,
                        avgvisKM: 10.0,
                        avgvisMiles: 6.2,
                        avghumidity: 65.0,
                        dailyWillItRain: 0,
                        dailyChanceOfRain: 0,
                        dailyWillItSnow: 0,
                        dailyChanceOfSnow: 0,
                        condition: Condition(
                            text: "Mostly sunny",
                            icon: "https://example.com/icons/mostly_sunny.png",
                            code: 1000
                        ),
                        uv: 7.0
                    ),
                    astro: Astro(
                        sunrise: "05:47 AM",
                        sunset: "08:18 PM",
                        moonrise: "11:00 PM",
                        moonset: "10:24 AM",
                        moonPhase: "Waning Gibbous",
                        moonIllumination: "60",
                        isMoonUp: 1,
                        isSunUp: 1
                    ),
                    hour: [
                        Hour(
                            timeEpoch: 1679846400,
                            time: "2023-07-27 00:00",
                            tempC: 22.0,
                            tempF: 71.6,
                            isDay: 0,
                            condition: Condition(
                                text: "Clear",
                                icon: "https://example.com/icons/clear.png",
                                code: 1000
                            ),
                            windMph: 2.9,
                            windKph: 4.7,
                            windDegree: 190,
                            windDir: "S",
                            pressureMB: 1017.1,
                            pressureIn: 30.04,
                            precipMm: 0.0,
                            precipIn: 0.0,
                            humidity: 65,
                            cloud: 10,
                            feelslikeC: 22.5,
                            feelslikeF: 72.5,
                            windchillC: 22.5,
                            windchillF: 72.5,
                            heatindexC: 22.0,
                            heatindexF: 71.6,
                            dewpointC: 15.0,
                            dewpointF: 59.0,
                            willItRain: 0,
                            chanceOfRain: 0,
                            willItSnow: 0,
                            chanceOfSnow: 0,
                            visKM: 10.0,
                            visMiles: 6.2,
                            gustMph: 4.6,
                            gustKph: 7.4,
                            uv: 0
                        ),
                        // Add more Hour objects for other time slots of the day
                        // ...
                    ]
                ),
                // Add more Forecastday objects for other days
                // ...
            ]
        )
    )
}
