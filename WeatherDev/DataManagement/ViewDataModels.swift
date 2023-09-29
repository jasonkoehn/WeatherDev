//
//  ViewDataModels.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/26/23.
//

import Foundation
import SwiftData

@Model
final class Location {
    @Attribute(.unique)
    var id: UUID
    var sortOrder: Int
    var expirationTime: Date
    var city: String
    var state: String
    var forecast: [Forecast]
    var forecastDiscussion: String
    var officeId: String
    var dailyForecastUrl: String
    var hourlyForecastUrl: String
    
    init(sortOrder: Int = 0, expirationTime: Date = Date(), city: String = "", state: String = "", forecast: [Forecast] = [], forecastDiscussion: String = "", officeId: String = "", dailyForecastUrl: String = "", hourlyForecastUrl: String = "") {
        self.id = UUID()
        self.sortOrder = sortOrder
        self.expirationTime = expirationTime
        self.city = city
        self.state = state
        self.forecast = forecast
        self.forecastDiscussion = forecastDiscussion
        self.officeId = officeId
        self.dailyForecastUrl = dailyForecastUrl
        self.hourlyForecastUrl = hourlyForecastUrl
    }
}

@Model
class Forecast: Equatable, Identifiable {
    var id: UUID
    var number: Int
    var name: String
    var startTime: Date
    var endTime: Date
    var isDaytime: Bool
    var temperature: Int
    var temperatureUnit: String
    var probabilityOfPrecipitation: Int
    var probabilityOfPrecipitationUnit: String
    var dewpointTemperature: Int
    var dewpointUnit: String
    var relativeHumidity: Int
    var relativeHumidityUnit: String
    var windSpeed: String
    var windDirection: String
    var icon: String
    var shortForecast: String
    var detailedForecast: String
    var hourlyForecast: [HourlyForecast]
    
    // Initializer
    init(number: Int, name: String, startTime: Date, endTime: Date, isDaytime: Bool, temperature: Int, probabilityOfPrecipitation: Int, dewpointTemperature: Int, relativeHumidity: Int, windSpeed: String, windDirection: String, icon: String, shortForecast: String, detailedForecast: String, hourlyForecast: [HourlyForecast]) {
        self.id = UUID()
        self.number = number
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.isDaytime = isDaytime
        self.temperature = temperature
        self.temperatureUnit = "°F"
        self.probabilityOfPrecipitation = probabilityOfPrecipitation
        self.probabilityOfPrecipitationUnit = "%"
        self.dewpointTemperature = dewpointTemperature
        self.dewpointUnit = "°F"
        self.relativeHumidity = relativeHumidity
        self.relativeHumidityUnit = "%"
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.icon = icon
        self.shortForecast = shortForecast
        self.detailedForecast = detailedForecast
        self.hourlyForecast = hourlyForecast
    }
}

@Model
class HourlyForecast: Equatable, Identifiable {
    var id: UUID
    var number: Int
    var startTime: Date
    var endTime: Date
    var hourOfDay: String
    var isDaytime: Bool
    var temperature: Int
    var temperatureUnit: String
    var probabilityOfPrecipitation: Int
    var probabilityOfPrecipitationUnit: String
    var dewpointTemperature: Int
    var dewpointUnit: String
    var relativeHumidity: Int
    var relativeHumidityUnit: String
    var windSpeed: String
    var windDirection: String
    var icon: String
    var shortForecast: String
    
    // Initializer
    init(number: Int, startTime: Date, endTime: Date, hourOfDay: String, isDaytime: Bool, temperature: Int, probabilityOfPrecipitation: Int, dewpointTemperature: Int, relativeHumidity: Int, windSpeed: String, windDirection: String, icon: String, shortForecast: String) {
        self.id = UUID()
        self.number = number
        self.startTime = startTime
        self.endTime = endTime
        self.hourOfDay = hourOfDay
        self.isDaytime = isDaytime
        self.temperature = temperature
        self.temperatureUnit = "°F"
        self.probabilityOfPrecipitation = probabilityOfPrecipitation
        self.probabilityOfPrecipitationUnit = "%"
        self.dewpointTemperature = dewpointTemperature
        self.dewpointUnit = "°F"
        self.relativeHumidity = relativeHumidity
        self.relativeHumidityUnit = "%"
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.icon = icon
        self.shortForecast = shortForecast
    }
}
