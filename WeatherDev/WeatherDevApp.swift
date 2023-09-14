//
//  WeatherDevApp.swift
//  WeatherDev
//
//  Created by Jason Koehn on 8/16/23.
//

import SwiftUI
import SwiftData

@main
struct WeatherDevApp: App {
    @StateObject var locationManager = LocationManager()
    @StateObject var locationSearchModel = LocationSearchModel()
    @StateObject var dataManager = DataManager()
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(locationManager)
                .environmentObject(locationSearchModel)
                .environmentObject(dataManager)
                .modelContainer(for: Location.self)
        }
    }
}
