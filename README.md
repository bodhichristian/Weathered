# Weathered
![Static Badge](https://img.shields.io/badge/Swift-orange)
![Static Badge](https://img.shields.io/badge/SwiftUI-orange)
![Static Badge](https://img.shields.io/badge/SwiftData-orange)
![Static Badge](https://img.shields.io/badge/MapKit-green)
![Static Badge](https://img.shields.io/badge/CoreLocation-blue)
![Static Badge](https://img.shields.io/badge/WeatherAPI-gray)
![Static Badge](https://img.shields.io/badge/MVVM-gray)

![trim 001](https://github.com/bodhichristian/Weathered/assets/110639779/eba86ea5-6d05-4e8a-9341-4280026ff6b8)

A SwiftUI app for searching and displaying the weather. Weathered is built using MVVM architecture and fetches real-time data from weatherapi.com.

### SwiftData
SwiftData is used to persist the user's favorite locations. These models are created from - and queried to - HomeView, where a user may add a searched city to favorites, or delete a favorite city with a long press on the corresponding tile in the ScrollView.

### MapKit & CoreLocation
MapKit is used to provide an immersive visual element as context in HomeView. If the device's location is not shared with Weathered, MapKit's satellite image of Earth will be the background view. If a user enables Location Services, the background view is a local map. In settings, the user may toggle between Satellite and Explore MapStyles.

### Weather Animations
Local conditions for searched cities dictate the animations provided for the sky--including daylight, stars, clouds, rain, snow, lightning, and condition intensity.

## 📲 Running in the Simulator
* An API key from weatherapi.com is required to run the project with real data.
  * Enter your API Key in Weathered/Services/WeatherService. Instructions are in the file. 
* Provide a location to your simulator from the Menu Bar: Features > Location

