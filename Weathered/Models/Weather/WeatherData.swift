//
//  WeatherData.swift
//  Weathered
//
//  Created by christian on 7/24/23.
//


import Foundation

// MARK: WeatherData
// A model to handle decoded JSON response from WeatherAPI.com
// JSON response example located at the bottom of this file

// MARK: WeatherData Object
struct WeatherData: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
    
    enum CodingKeys: String, CodingKey {
        case location, current, forecast
    }
}

// MARK: Current
struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMB: Double
    let pressureIn: Double
    let precipMm, precipIn: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF: Double
    let visKM, visMiles, uv, gustMph, gustKph: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}


// MARK: Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}


// MARK: Forecastday
struct Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: Astro
struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset, moonPhase, moonIllumination: String
    let isMoonUp, isSunUp: Int

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

// MARK: Day
struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Double
    let avgtempC, avgtempF, maxwindMph, maxwindKph, totalprecipMm, totalprecipIn, totalsnowCM, avgvisKM, avgvisMiles, avghumidity: Double
    let dailyWillItRain, dailyChanceOfRain: Int
    let dailyWillItSnow, dailyChanceOfSnow: Int
    let condition: Condition
    let uv: Double

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCM = "totalsnow_cm"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}

// MARK: Hour
struct Hour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMB: Double
    let pressureIn, precipMm, precipIn: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF, windchillC, windchillF, heatindexC, heatindexF, dewpointC, dewpointF: Double
    let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Int
    let visKM, visMiles: Double
    let gustMph, gustKph: Double
    let uv: Int

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
}

// MARK: Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}



// JSON RESPONSE
/*
 {
     "location": {
         "name": "New York",
         "region": "New York",
         "country": "United States of America",
         "lat": 40.71,
         "lon": -74.01,
         "tz_id": "America/New_York",
         "localtime_epoch": 1690286250,
         "localtime": "2023-07-25 7:57"
     },
     "current": {
         "last_updated_epoch": 1690285500,
         "last_updated": "2023-07-25 07:45",
         "temp_c": 23.9,
         "temp_f": 75.0,
         "is_day": 1,
         "condition": {
             "text": "Overcast",
             "icon": "//cdn.weatherapi.com/weather/64x64/day/122.png",
             "code": 1009
         },
         "wind_mph": 2.2,
         "wind_kph": 3.6,
         "wind_degree": 234,
         "wind_dir": "SW",
         "pressure_mb": 1019.0,
         "pressure_in": 30.1,
         "precip_mm": 0.0,
         "precip_in": 0.0,
         "humidity": 74,
         "cloud": 100,
         "feelslike_c": 25.8,
         "feelslike_f": 78.4,
         "vis_km": 16.0,
         "vis_miles": 9.0,
         "uv": 6.0,
         "gust_mph": 7.8,
         "gust_kph": 12.6
     },
     "forecast": {
         "forecastday": [
             {
                 "date": "2023-07-25",
                 "date_epoch": 1690243200,
                 "day": {
                     "maxtemp_c": 33.1,
                     "maxtemp_f": 91.6,
                     "mintemp_c": 20.2,
                     "mintemp_f": 68.4,
                     "avgtemp_c": 25.1,
                     "avgtemp_f": 77.2,
                     "maxwind_mph": 14.3,
                     "maxwind_kph": 23.0,
                     "totalprecip_mm": 23.6,
                     "totalprecip_in": 0.93,
                     "totalsnow_cm": 0.0,
                     "avgvis_km": 9.7,
                     "avgvis_miles": 6.0,
                     "avghumidity": 82.0,
                     "daily_will_it_rain": 1,
                     "daily_chance_of_rain": 88,
                     "daily_will_it_snow": 0,
                     "daily_chance_of_snow": 0,
                     "condition": {
                         "text": "Heavy rain",
                         "icon": "//cdn.weatherapi.com/weather/64x64/day/308.png",
                         "code": 1195
                     },
                     "uv": 6.0
                 },
                 "astro": {
                     "sunrise": "05:46 AM",
                     "sunset": "08:18 PM",
                     "moonrise": "01:17 PM",
                     "moonset": "No moonset",
                     "moon_phase": "First Quarter",
                     "moon_illumination": "41",
                     "is_moon_up": 1,
                     "is_sun_up": 1
                 },
                 "hour": [
                     {
                         "time_epoch": 1690257600,
                         "time": "2023-07-25 00:00",
                         "temp_c": 25.0,
                         "temp_f": 77.0,
                         "is_day": 0,
                         "condition": {
                             "text": "Clear",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                             "code": 1000
                         },
                         "wind_mph": 9.4,
                         "wind_kph": 15.1,
                         "wind_degree": 199,
                         "wind_dir": "SSW",
                         "pressure_mb": 1019.0,
                         "pressure_in": 30.08,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 69,
                         "cloud": 13,
                         "feelslike_c": 26.6,
                         "feelslike_f": 79.9,
                         "windchill_c": 25.0,
                         "windchill_f": 77.0,
                         "heatindex_c": 26.6,
                         "heatindex_f": 79.9,
                         "dewpoint_c": 18.9,
                         "dewpoint_f": 66.0,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 13.0,
                         "gust_kph": 20.9,
                         "uv": 1.0
                     },
                     {
                         "time_epoch": 1690261200,
                         "time": "2023-07-25 01:00",
                         "temp_c": 24.6,
                         "temp_f": 76.3,
                         "is_day": 0,
                         "condition": {
                             "text": "Clear",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                             "code": 1000
                         },
                         "wind_mph": 8.5,
                         "wind_kph": 13.7,
                         "wind_degree": 211,
                         "wind_dir": "SSW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.07,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 71,
                         "cloud": 19,
                         "feelslike_c": 26.2,
                         "feelslike_f": 79.2,
                         "windchill_c": 24.6,
                         "windchill_f": 76.3,
                         "heatindex_c": 26.2,
                         "heatindex_f": 79.2,
                         "dewpoint_c": 18.9,
                         "dewpoint_f": 66.0,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 11.9,
                         "gust_kph": 19.1,
                         "uv": 1.0
                     },
                     {
                         "time_epoch": 1690264800,
                         "time": "2023-07-25 02:00",
                         "temp_c": 24.1,
                         "temp_f": 75.4,
                         "is_day": 0,
                         "condition": {
                             "text": "Clear",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                             "code": 1000
                         },
                         "wind_mph": 7.6,
                         "wind_kph": 12.2,
                         "wind_degree": 220,
                         "wind_dir": "SW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.07,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 73,
                         "cloud": 24,
                         "feelslike_c": 25.8,
                         "feelslike_f": 78.4,
                         "windchill_c": 24.1,
                         "windchill_f": 75.4,
                         "heatindex_c": 25.8,
                         "heatindex_f": 78.4,
                         "dewpoint_c": 18.9,
                         "dewpoint_f": 66.0,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 10.7,
                         "gust_kph": 17.3,
                         "uv": 1.0
                     },
                     {
                         "time_epoch": 1690268400,
                         "time": "2023-07-25 03:00",
                         "temp_c": 23.8,
                         "temp_f": 74.8,
                         "is_day": 0,
                         "condition": {
                             "text": "Clear",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                             "code": 1000
                         },
                         "wind_mph": 6.7,
                         "wind_kph": 10.8,
                         "wind_degree": 222,
                         "wind_dir": "SW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.06,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 74,
                         "cloud": 10,
                         "feelslike_c": 25.6,
                         "feelslike_f": 78.1,
                         "windchill_c": 23.8,
                         "windchill_f": 74.8,
                         "heatindex_c": 25.6,
                         "heatindex_f": 78.1,
                         "dewpoint_c": 19.0,
                         "dewpoint_f": 66.2,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 9.4,
                         "gust_kph": 15.1,
                         "uv": 1.0
                     },
                     {
                         "time_epoch": 1690272000,
                         "time": "2023-07-25 04:00",
                         "temp_c": 23.5,
                         "temp_f": 74.3,
                         "is_day": 0,
                         "condition": {
                             "text": "Clear",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                             "code": 1000
                         },
                         "wind_mph": 6.0,
                         "wind_kph": 9.7,
                         "wind_degree": 226,
                         "wind_dir": "SW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.06,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 75,
                         "cloud": 12,
                         "feelslike_c": 25.4,
                         "feelslike_f": 77.7,
                         "windchill_c": 23.5,
                         "windchill_f": 74.3,
                         "heatindex_c": 25.4,
                         "heatindex_f": 77.7,
                         "dewpoint_c": 18.9,
                         "dewpoint_f": 66.0,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 8.5,
                         "gust_kph": 13.7,
                         "uv": 1.0
                     },
                     {
                         "time_epoch": 1690275600,
                         "time": "2023-07-25 05:00",
                         "temp_c": 23.3,
                         "temp_f": 73.9,
                         "is_day": 0,
                         "condition": {
                             "text": "Clear",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                             "code": 1000
                         },
                         "wind_mph": 5.1,
                         "wind_kph": 8.3,
                         "wind_degree": 232,
                         "wind_dir": "SW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.06,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 77,
                         "cloud": 8,
                         "feelslike_c": 25.2,
                         "feelslike_f": 77.4,
                         "windchill_c": 23.3,
                         "windchill_f": 73.9,
                         "heatindex_c": 25.2,
                         "heatindex_f": 77.4,
                         "dewpoint_c": 19.0,
                         "dewpoint_f": 66.2,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 7.2,
                         "gust_kph": 11.5,
                         "uv": 1.0
                     },
                     {
                         "time_epoch": 1690279200,
                         "time": "2023-07-25 06:00",
                         "temp_c": 23.0,
                         "temp_f": 73.4,
                         "is_day": 1,
                         "condition": {
                             "text": "Sunny",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                             "code": 1000
                         },
                         "wind_mph": 5.1,
                         "wind_kph": 8.3,
                         "wind_degree": 234,
                         "wind_dir": "SW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.07,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 79,
                         "cloud": 8,
                         "feelslike_c": 25.1,
                         "feelslike_f": 77.2,
                         "windchill_c": 23.0,
                         "windchill_f": 73.4,
                         "heatindex_c": 25.1,
                         "heatindex_f": 77.2,
                         "dewpoint_c": 19.1,
                         "dewpoint_f": 66.4,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 7.2,
                         "gust_kph": 11.5,
                         "uv": 6.0
                     },
                     {
                         "time_epoch": 1690282800,
                         "time": "2023-07-25 07:00",
                         "temp_c": 23.3,
                         "temp_f": 73.9,
                         "is_day": 1,
                         "condition": {
                             "text": "Sunny",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                             "code": 1000
                         },
                         "wind_mph": 6.0,
                         "wind_kph": 9.7,
                         "wind_degree": 234,
                         "wind_dir": "SW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.07,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 78,
                         "cloud": 5,
                         "feelslike_c": 25.3,
                         "feelslike_f": 77.5,
                         "windchill_c": 23.3,
                         "windchill_f": 73.9,
                         "heatindex_c": 25.3,
                         "heatindex_f": 77.5,
                         "dewpoint_c": 19.3,
                         "dewpoint_f": 66.7,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 7.8,
                         "gust_kph": 12.6,
                         "uv": 6.0
                     },
                     {
                         "time_epoch": 1690286400,
                         "time": "2023-07-25 08:00",
                         "temp_c": 24.1,
                         "temp_f": 75.4,
                         "is_day": 1,
                         "condition": {
                             "text": "Sunny",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                             "code": 1000
                         },
                         "wind_mph": 6.3,
                         "wind_kph": 10.1,
                         "wind_degree": 235,
                         "wind_dir": "SW",
                         "pressure_mb": 1019.0,
                         "pressure_in": 30.08,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 75,
                         "cloud": 8,
                         "feelslike_c": 25.9,
                         "feelslike_f": 78.6,
                         "windchill_c": 24.1,
                         "windchill_f": 75.4,
                         "heatindex_c": 25.9,
                         "heatindex_f": 78.6,
                         "dewpoint_c": 19.4,
                         "dewpoint_f": 66.9,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 7.6,
                         "gust_kph": 12.2,
                         "uv": 6.0
                     },
                     {
                         "time_epoch": 1690290000,
                         "time": "2023-07-25 09:00",
                         "temp_c": 25.5,
                         "temp_f": 77.9,
                         "is_day": 1,
                         "condition": {
                             "text": "Sunny",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                             "code": 1000
                         },
                         "wind_mph": 6.0,
                         "wind_kph": 9.7,
                         "wind_degree": 231,
                         "wind_dir": "SW",
                         "pressure_mb": 1019.0,
                         "pressure_in": 30.08,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 69,
                         "cloud": 10,
                         "feelslike_c": 27.1,
                         "feelslike_f": 80.8,
                         "windchill_c": 25.5,
                         "windchill_f": 77.9,
                         "heatindex_c": 27.1,
                         "heatindex_f": 80.8,
                         "dewpoint_c": 19.4,
                         "dewpoint_f": 66.9,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 6.9,
                         "gust_kph": 11.2,
                         "uv": 7.0
                     },
                     {
                         "time_epoch": 1690293600,
                         "time": "2023-07-25 10:00",
                         "temp_c": 27.1,
                         "temp_f": 80.8,
                         "is_day": 1,
                         "condition": {
                             "text": "Sunny",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                             "code": 1000
                         },
                         "wind_mph": 6.5,
                         "wind_kph": 10.4,
                         "wind_degree": 228,
                         "wind_dir": "SW",
                         "pressure_mb": 1019.0,
                         "pressure_in": 30.08,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 61,
                         "cloud": 4,
                         "feelslike_c": 28.6,
                         "feelslike_f": 83.5,
                         "windchill_c": 27.1,
                         "windchill_f": 80.8,
                         "heatindex_c": 28.6,
                         "heatindex_f": 83.5,
                         "dewpoint_c": 19.0,
                         "dewpoint_f": 66.2,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 7.4,
                         "gust_kph": 11.9,
                         "uv": 7.0
                     },
                     {
                         "time_epoch": 1690297200,
                         "time": "2023-07-25 11:00",
                         "temp_c": 31.6,
                         "temp_f": 88.9,
                         "is_day": 1,
                         "condition": {
                             "text": "Sunny",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                             "code": 1000
                         },
                         "wind_mph": 6.7,
                         "wind_kph": 10.8,
                         "wind_degree": 218,
                         "wind_dir": "SW",
                         "pressure_mb": 1019.0,
                         "pressure_in": 30.08,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 53,
                         "cloud": 7,
                         "feelslike_c": 34.8,
                         "feelslike_f": 94.6,
                         "windchill_c": 31.6,
                         "windchill_f": 88.9,
                         "heatindex_c": 34.8,
                         "heatindex_f": 94.6,
                         "dewpoint_c": 20.9,
                         "dewpoint_f": 69.6,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 7.8,
                         "gust_kph": 12.6,
                         "uv": 8.0
                     },
                     {
                         "time_epoch": 1690300800,
                         "time": "2023-07-25 12:00",
                         "temp_c": 32.9,
                         "temp_f": 91.2,
                         "is_day": 1,
                         "condition": {
                             "text": "Sunny",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                             "code": 1000
                         },
                         "wind_mph": 6.7,
                         "wind_kph": 10.8,
                         "wind_degree": 200,
                         "wind_dir": "SSW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.07,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 48,
                         "cloud": 7,
                         "feelslike_c": 36.0,
                         "feelslike_f": 96.8,
                         "windchill_c": 32.9,
                         "windchill_f": 91.2,
                         "heatindex_c": 36.0,
                         "heatindex_f": 96.8,
                         "dewpoint_c": 20.3,
                         "dewpoint_f": 68.5,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 7.8,
                         "gust_kph": 12.6,
                         "uv": 8.0
                     },
                     {
                         "time_epoch": 1690304400,
                         "time": "2023-07-25 13:00",
                         "temp_c": 32.1,
                         "temp_f": 89.8,
                         "is_day": 1,
                         "condition": {
                             "text": "Partly cloudy",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                             "code": 1003
                         },
                         "wind_mph": 8.5,
                         "wind_kph": 13.7,
                         "wind_degree": 182,
                         "wind_dir": "S",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.05,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 46,
                         "cloud": 26,
                         "feelslike_c": 34.1,
                         "feelslike_f": 93.4,
                         "windchill_c": 32.1,
                         "windchill_f": 89.8,
                         "heatindex_c": 34.1,
                         "heatindex_f": 93.4,
                         "dewpoint_c": 18.9,
                         "dewpoint_f": 66.0,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 9.8,
                         "gust_kph": 15.8,
                         "uv": 8.0
                     },
                     {
                         "time_epoch": 1690308000,
                         "time": "2023-07-25 14:00",
                         "temp_c": 31.2,
                         "temp_f": 88.2,
                         "is_day": 1,
                         "condition": {
                             "text": "Partly cloudy",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                             "code": 1003
                         },
                         "wind_mph": 11.9,
                         "wind_kph": 19.1,
                         "wind_degree": 173,
                         "wind_dir": "S",
                         "pressure_mb": 1017.0,
                         "pressure_in": 30.04,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 46,
                         "cloud": 40,
                         "feelslike_c": 32.6,
                         "feelslike_f": 90.7,
                         "windchill_c": 31.2,
                         "windchill_f": 88.2,
                         "heatindex_c": 32.6,
                         "heatindex_f": 90.7,
                         "dewpoint_c": 18.1,
                         "dewpoint_f": 64.6,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 13.6,
                         "gust_kph": 22.0,
                         "uv": 8.0
                     },
                     {
                         "time_epoch": 1690311600,
                         "time": "2023-07-25 15:00",
                         "temp_c": 30.3,
                         "temp_f": 86.5,
                         "is_day": 1,
                         "condition": {
                             "text": "Thundery outbreaks possible",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/200.png",
                             "code": 1087
                         },
                         "wind_mph": 12.5,
                         "wind_kph": 20.2,
                         "wind_degree": 169,
                         "wind_dir": "S",
                         "pressure_mb": 1017.0,
                         "pressure_in": 30.03,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 49,
                         "cloud": 43,
                         "feelslike_c": 31.8,
                         "feelslike_f": 89.2,
                         "windchill_c": 30.3,
                         "windchill_f": 86.5,
                         "heatindex_c": 31.8,
                         "heatindex_f": 89.2,
                         "dewpoint_c": 18.3,
                         "dewpoint_f": 64.9,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 9.0,
                         "vis_miles": 5.0,
                         "gust_mph": 14.3,
                         "gust_kph": 23.0,
                         "uv": 7.0
                     },
                     {
                         "time_epoch": 1690315200,
                         "time": "2023-07-25 16:00",
                         "temp_c": 29.5,
                         "temp_f": 85.1,
                         "is_day": 1,
                         "condition": {
                             "text": "Sunny",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                             "code": 1000
                         },
                         "wind_mph": 14.8,
                         "wind_kph": 23.8,
                         "wind_degree": 170,
                         "wind_dir": "S",
                         "pressure_mb": 1016.0,
                         "pressure_in": 30.01,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 52,
                         "cloud": 23,
                         "feelslike_c": 31.0,
                         "feelslike_f": 87.8,
                         "windchill_c": 29.5,
                         "windchill_f": 85.1,
                         "heatindex_c": 31.0,
                         "heatindex_f": 87.8,
                         "dewpoint_c": 18.6,
                         "dewpoint_f": 65.5,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 17.0,
                         "gust_kph": 27.4,
                         "uv": 7.0
                     },
                     {
                         "time_epoch": 1690318800,
                         "time": "2023-07-25 17:00",
                         "temp_c": 29.1,
                         "temp_f": 84.4,
                         "is_day": 1,
                         "condition": {
                             "text": "Partly cloudy",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                             "code": 1003
                         },
                         "wind_mph": 14.3,
                         "wind_kph": 23.0,
                         "wind_degree": 180,
                         "wind_dir": "S",
                         "pressure_mb": 1016.0,
                         "pressure_in": 30.01,
                         "precip_mm": 0.1,
                         "precip_in": 0.0,
                         "humidity": 55,
                         "cloud": 45,
                         "feelslike_c": 30.8,
                         "feelslike_f": 87.4,
                         "windchill_c": 29.1,
                         "windchill_f": 84.4,
                         "heatindex_c": 30.8,
                         "heatindex_f": 87.4,
                         "dewpoint_c": 19.1,
                         "dewpoint_f": 66.4,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 16.6,
                         "gust_kph": 26.6,
                         "uv": 7.0
                     },
                     {
                         "time_epoch": 1690322400,
                         "time": "2023-07-25 18:00",
                         "temp_c": 28.0,
                         "temp_f": 82.4,
                         "is_day": 1,
                         "condition": {
                             "text": "Partly cloudy",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                             "code": 1003
                         },
                         "wind_mph": 11.2,
                         "wind_kph": 18.0,
                         "wind_degree": 178,
                         "wind_dir": "S",
                         "pressure_mb": 1016.0,
                         "pressure_in": 30.01,
                         "precip_mm": 0.0,
                         "precip_in": 0.0,
                         "humidity": 60,
                         "cloud": 26,
                         "feelslike_c": 29.7,
                         "feelslike_f": 85.5,
                         "windchill_c": 28.0,
                         "windchill_f": 82.4,
                         "heatindex_c": 29.7,
                         "heatindex_f": 85.5,
                         "dewpoint_c": 19.4,
                         "dewpoint_f": 66.9,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 13.6,
                         "gust_kph": 22.0,
                         "uv": 7.0
                     },
                     {
                         "time_epoch": 1690326000,
                         "time": "2023-07-25 19:00",
                         "temp_c": 27.9,
                         "temp_f": 82.2,
                         "is_day": 1,
                         "condition": {
                             "text": "Thundery outbreaks possible",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/200.png",
                             "code": 1087
                         },
                         "wind_mph": 9.6,
                         "wind_kph": 15.5,
                         "wind_degree": 176,
                         "wind_dir": "S",
                         "pressure_mb": 1017.0,
                         "pressure_in": 30.02,
                         "precip_mm": 0.1,
                         "precip_in": 0.0,
                         "humidity": 60,
                         "cloud": 53,
                         "feelslike_c": 29.6,
                         "feelslike_f": 85.3,
                         "windchill_c": 27.9,
                         "windchill_f": 82.2,
                         "heatindex_c": 29.6,
                         "heatindex_f": 85.3,
                         "dewpoint_c": 19.4,
                         "dewpoint_f": 66.9,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 9.0,
                         "vis_miles": 5.0,
                         "gust_mph": 12.3,
                         "gust_kph": 19.8,
                         "uv": 6.0
                     },
                     {
                         "time_epoch": 1690329600,
                         "time": "2023-07-25 20:00",
                         "temp_c": 26.0,
                         "temp_f": 78.8,
                         "is_day": 1,
                         "condition": {
                             "text": "Light rain shower",
                             "icon": "//cdn.weatherapi.com/weather/64x64/day/353.png",
                             "code": 1240
                         },
                         "wind_mph": 8.3,
                         "wind_kph": 13.3,
                         "wind_degree": 187,
                         "wind_dir": "S",
                         "pressure_mb": 1017.0,
                         "pressure_in": 30.03,
                         "precip_mm": 1.5,
                         "precip_in": 0.06,
                         "humidity": 71,
                         "cloud": 53,
                         "feelslike_c": 27.9,
                         "feelslike_f": 82.2,
                         "windchill_c": 26.0,
                         "windchill_f": 78.8,
                         "heatindex_c": 27.9,
                         "heatindex_f": 82.2,
                         "dewpoint_c": 20.4,
                         "dewpoint_f": 68.7,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 13.0,
                         "gust_kph": 20.9,
                         "uv": 6.0
                     },
                     {
                         "time_epoch": 1690333200,
                         "time": "2023-07-25 21:00",
                         "temp_c": 26.0,
                         "temp_f": 78.8,
                         "is_day": 0,
                         "condition": {
                             "text": "Patchy light rain with thunder",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/386.png",
                             "code": 1273
                         },
                         "wind_mph": 7.6,
                         "wind_kph": 12.2,
                         "wind_degree": 192,
                         "wind_dir": "SSW",
                         "pressure_mb": 1018.0,
                         "pressure_in": 30.05,
                         "precip_mm": 1.5,
                         "precip_in": 0.06,
                         "humidity": 72,
                         "cloud": 28,
                         "feelslike_c": 27.9,
                         "feelslike_f": 82.2,
                         "windchill_c": 26.0,
                         "windchill_f": 78.8,
                         "heatindex_c": 27.9,
                         "heatindex_f": 82.2,
                         "dewpoint_c": 20.5,
                         "dewpoint_f": 68.9,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 10.0,
                         "vis_miles": 6.0,
                         "gust_mph": 11.9,
                         "gust_kph": 19.1,
                         "uv": 1.0
                     },
                     {
                         "time_epoch": 1690336800,
                         "time": "2023-07-25 22:00",
                         "temp_c": 25.6,
                         "temp_f": 78.1,
                         "is_day": 0,
                         "condition": {
                             "text": "Patchy rain possible",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/176.png",
                             "code": 1063
                         },
                         "wind_mph": 6.3,
                         "wind_kph": 10.1,
                         "wind_degree": 195,
                         "wind_dir": "SSW",
                         "pressure_mb": 1017.0,
                         "pressure_in": 30.04,
                         "precip_mm": 1.1,
                         "precip_in": 0.04,
                         "humidity": 75,
                         "cloud": 15,
                         "feelslike_c": 27.6,
                         "feelslike_f": 81.7,
                         "windchill_c": 25.6,
                         "windchill_f": 78.1,
                         "heatindex_c": 27.6,
                         "heatindex_f": 81.7,
                         "dewpoint_c": 20.8,
                         "dewpoint_f": 69.4,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 9.0,
                         "vis_miles": 5.0,
                         "gust_mph": 10.1,
                         "gust_kph": 16.2,
                         "uv": 1.0
                     },
                     {
                         "time_epoch": 1690340400,
                         "time": "2023-07-25 23:00",
                         "temp_c": 25.5,
                         "temp_f": 77.9,
                         "is_day": 0,
                         "condition": {
                             "text": "Moderate or heavy rain shower",
                             "icon": "//cdn.weatherapi.com/weather/64x64/night/356.png",
                             "code": 1243
                         },
                         "wind_mph": 8.1,
                         "wind_kph": 13.0,
                         "wind_degree": 226,
                         "wind_dir": "SW",
                         "pressure_mb": 1017.0,
                         "pressure_in": 30.04,
                         "precip_mm": 3.4,
                         "precip_in": 0.13,
                         "humidity": 73,
                         "cloud": 16,
                         "feelslike_c": 27.3,
                         "feelslike_f": 81.1,
                         "windchill_c": 25.5,
                         "windchill_f": 77.9,
                         "heatindex_c": 27.3,
                         "heatindex_f": 81.1,
                         "dewpoint_c": 20.4,
                         "dewpoint_f": 68.7,
                         "will_it_rain": 0,
                         "chance_of_rain": 0,
                         "will_it_snow": 0,
                         "chance_of_snow": 0,
                         "vis_km": 7.0,
                         "vis_miles": 4.0,
                         "gust_mph": 13.6,
                         "gust_kph": 22.0,
                         "uv": 1.0
                     }
                 ]
             }
         ]
     }
 }
 */
