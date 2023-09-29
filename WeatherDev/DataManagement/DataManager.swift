//
//  DataManager.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/27/23.
//

import Foundation

class DataManager: ObservableObject {
    
    // User Location Fetch
    func getUserLocation(latitude: Double, longitude: Double) async -> Location {
        let location = Location()
        UserLocationManager().getUserAddress(latitude: latitude, longitude: longitude) { place, error in
            location.city = place?.locality ?? ""
            location.state = place?.administrativeArea ?? ""
        }
        if let locationUrls = await locationUrlsRequest(latitude: latitude, longitude: longitude) {
            location.officeId = locationUrls.gridId
            location.dailyForecastUrl = locationUrls.forecast
            location.hourlyForecastUrl = locationUrls.forecastHourly
        } else {
            return Location()
        }
        return location
    }
    
    // Decoding
    func celsiusToFahrenheit(celsius: Double) -> Int {
        let celsius = Measurement(value: celsius, unit: UnitTemperature.celsius)
        let fahrenheit = Int(celsius.converted(to: .fahrenheit).value)
        return fahrenheit
    }
    func convertToDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        if let date = dateFormatter.date(from: string) {
            return date
        } else {
            print("Error parsing date")
            return Date()
        }
    }
    
    
    // Url requests
    func locationUrlsRequest(latitude: Double, longitude: Double) async -> LocationUrlModel? {
        let url = "https://api.weather.gov/points/\(latitude),\(longitude)"
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }
        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
            let (data, _) = try await URLSession(configuration: .ephemeral).data(from: url)
            return try? JSONDecoder().decode(LocationUrlPropertiesModel.self, from: data).properties
        } catch {
            print("Invalid Data")
            return nil
        }
    }
    
    func forecastUrlRequest(url: String) async -> [Forecast] {
        var forecast: [Forecast] = []
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
//            let (data, _) = try await URLSession(configuration: .ephemeral).data(from: url)
            if let response = try? JSONDecoder().decode(ForecastFileModel.self, from: data) {
                for period in response.properties.periods {
                    forecast.append(Forecast(number: period.number, name: period.name, startTime: convertToDate(string: period.startTime), endTime: convertToDate(string: period.endTime), isDaytime: period.isDaytime, temperature: period.temperature, probabilityOfPrecipitation: Int(period.probabilityOfPrecipitation.value ?? 0), dewpointTemperature: celsiusToFahrenheit(celsius: period.dewpoint.value), relativeHumidity: Int(period.relativeHumidity.value), windSpeed: period.windSpeed, windDirection: period.windDirection, icon: period.icon, shortForecast: period.shortForecast, detailedForecast: period.detailedForecast, hourlyForecast: []))
                }
            }
        } catch {
            print("Invalid Data")
            return []
        }
        return forecast
    }
    
    func propertiesUrlRequest(officeId: String) async -> String? {
        let url = "https://api.weather.gov/products/types/AFD/locations/"+officeId
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }
        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
            let (data, _) = try await URLSession(configuration: .ephemeral).data(from: url)
            return try? JSONDecoder().decode(ProductsFileModel.self, from: data).graph.first?.id
        } catch {
            print("Invalid Data")
            return nil
        }
    }
    func discussionUrlRequest(urlId: String) async -> String? {
        let url = "https://api.weather.gov/products/"+urlId
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }
        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
            let (data, _) = try await URLSession(configuration: .ephemeral).data(from: url)
            return try? JSONDecoder().decode(DiscussionModel.self, from: data).productText
        } catch {
            print("Invalid Data")
            return nil
        }
    }
}
