//
//  DataModels.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/12/23.
//

import Foundation
import SwiftData

@Model
class Location {
    var id: UUID
    var name: String
    var state: String
    var officeId: String
    var dailyForecastUrl: String
    var hourlyForecastUrl: String
    
    init(name: String, state: String, officeId: String, dailyForecastUrl: String, hourlyForecastUrl: String) {
        self.id = UUID()
        self.name = name
        self.state = state
        self.officeId = officeId
        self.dailyForecastUrl = dailyForecastUrl
        self.hourlyForecastUrl = hourlyForecastUrl
    }
}

struct LoadedLocation: Identifiable {
    var id: UUID
    var name: String
    var state: String
    var forecast: [Forecast]
}
struct Forecast {
    var number: Int
    var name: String
    var isDaytime: Bool
    var temperature: Int
    var temperatureUnit: String
    var windSpeed: String
    var windDirection: String
    var icon: String
    var shortForecast: String
    var detailedForecast: String
}

// Location URLs
struct LocationUrlPropertiesModel: Codable {
    var properties: LocationUrlModel
}
struct LocationUrlModel: Codable {
    var gridId: String
    var forecast: String
    var forecastHourly: String
}

// Forecast API Model
struct ForecastFileModel: Codable {
    var properties: ForecastPropertiesModel
}
struct ForecastPropertiesModel: Codable {
    var periods: [ForecastItemsModel]
}
struct ForecastItemsModel: Codable {
    var number: Int
    var name: String
    var startTime: String
    var endTime: String
    var isDaytime: Bool
    var temperature: Int
    var temperatureUnit: String
    var temperatureTrend: String?
//    var probabilityOfPrecipitation: ProbabilityOfPrecipitation
//    var dewpoint: Dewpoint
//    var relativeHumidity: RelativeHumidity
    var windSpeed: String
    var windDirection: String
    var icon: String
    var shortForecast: String
    var detailedForecast: String
    
    struct ProbabilityOfPrecipitation: Codable {
        var unitCode: String
        var value: Double
    }
    struct Dewpoint: Codable {
        var unitCode: String
        var value: Double
    }
    struct RelativeHumidity: Codable {
        var unitCode: String
        var value: Double
    }
}
