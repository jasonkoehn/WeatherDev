//
//  DataManager.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/1/23.
//

import Foundation

class DataManager: ObservableObject {
    
    func getUserLocationData(latitude: Double, longitude: Double) async -> Location? {
        let userLocation: Location = Location(name: "", state: "", officeId: "", dailyForecastUrl: "", hourlyForecastUrl: "")
        LocationManager().getUserAddress(latitude: latitude, longitude: longitude) { place, error in
            userLocation.name = place?.locality ?? ""
            userLocation.state = place?.administrativeArea ?? ""
        }
        if let locationUrls = await getLocationUrlsRequest(latitude: latitude, longitude: longitude) {
            userLocation.officeId = locationUrls.gridId
            userLocation.dailyForecastUrl = locationUrls.forecast
            userLocation.hourlyForecastUrl = locationUrls.forecastHourly
        } else {
            return nil
        }
        return userLocation
    }
    
    func getForecast(location: Location) async -> LoadedLocation? {
        var loadedLocation: LoadedLocation = LoadedLocation(id: location.id, name: location.name, state: location.state, forecast: [])
        if let dailyForecastItems = await getForecastUrlRequest(url: location.dailyForecastUrl) {
            for item in dailyForecastItems {
                loadedLocation.forecast.append(Forecast(number: item.number, name: item.name, isDaytime: item.isDaytime, temperature: item.temperature, temperatureUnit: item.temperatureUnit, windSpeed: item.windSpeed, windDirection: item.windDirection, icon: item.icon, shortForecast: item.shortForecast, detailedForecast: item.detailedForecast))
            }
            loadedLocation.forecast.sort {
                $0.number < $1.number
            }
            return loadedLocation
        } else {
            return nil
        }
    }
    
    func getLocationUrlsRequest(latitude: Double, longitude: Double) async -> LocationUrlModel? {
        guard let url = URL(string: "https://api.weather.gov/points/\(latitude),\(longitude)") else {
            print("Invalid URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try? JSONDecoder().decode(LocationUrlPropertiesModel.self, from: data).properties
        } catch {
            print("Invalid Data")
            return nil
        }
    }
    
    func getForecastUrlRequest(url: String) async -> [ForecastItemsModel]? {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try? JSONDecoder().decode(ForecastFileModel.self, from: data).properties.periods
        } catch {
            print("Invalid Data")
            return nil
        }
    }
}
