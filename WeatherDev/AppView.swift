//
//  AppView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/26/23.
//

import SwiftUI
import SwiftData

struct AppView: View {
    @StateObject private var userLocationManager = UserLocationManager()
    @StateObject private var locationSearchManager = LocationSearchManager()
    @StateObject private var dataManager = DataManager()
    var body: some View {
        LocationsHomeView()
            .environmentObject(userLocationManager)
            .environmentObject(locationSearchManager)
            .environmentObject(dataManager)
            .modelContainer(for: [Location.self, Forecast.self, HourlyForecast.self])
    }
}

#Preview {
    AppView()
}
