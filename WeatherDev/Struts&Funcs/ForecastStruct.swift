//
//  ForecastStruct.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/1/23.
//

import Foundation

struct ForecastModel: Codable, Equatable {
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

//{
//    "number": 1,
//    "name": "This Afternoon",
//    "startTime": "2023-08-31T14:00:00-07:00",
//    "endTime": "2023-08-31T18:00:00-07:00",
//    "isDaytime": true,
//    "temperature": 98,
//    "temperatureUnit": "F",
//    "temperatureTrend": null,
//    "probabilityOfPrecipitation": {
//        "unitCode": "wmoUnit:percent",
//        "value": 40
//    },
//    "dewpoint": {
//        "unitCode": "wmoUnit:degC",
//        "value": 11.111111111111111
//    },
//    "relativeHumidity": {
//        "unitCode": "wmoUnit:percent",
//        "value": 22
//    },
//    "windSpeed": "5 to 8 mph",
//    "windDirection": "SSE",
//    "icon": "https://api.weather.gov/icons/land/day/tsra_hi,40?size=medium",
//    "shortForecast": "Chance Showers And Thunderstorms",
//    "detailedForecast": "A chance of showers and thunderstorms. Partly sunny, with a high near 98. South southeast wind 5 to 8 mph. Chance of precipitation is 40%."
//}
