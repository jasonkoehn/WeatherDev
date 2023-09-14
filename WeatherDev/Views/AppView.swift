//
//  AppView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/11/23.
//

import SwiftUI
import SwiftData

struct AppView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var locationSearchModel: LocationSearchModel
    @EnvironmentObject var dataManager: DataManager
    @Query private var locations: [Location]
    @State var loadedUserLocation: LoadedLocation? = nil
    @State var loadedLocations: [LoadedLocation]? = []
    var body: some View {
        NavigationStack {
            if locationSearchModel.searchText == "" {
                WeatherLocationsView(loadedUserLocation: $loadedUserLocation, loadedLocations: $loadedLocations)
                    .navigationTitle("Weather")
            } else {
                LocationSearchResultsView()
            }
        }
        .searchable(text: $locationSearchModel.searchText)
        .task {
            if let userLocation = await dataManager.getUserLocationData(latitude: locationManager.latitude, longitude: locationManager.longitude) {
                loadedUserLocation = await dataManager.getForecast(location: userLocation)
            }
            for location in locations {
                if let loadedLocation = await dataManager.getForecast(location: location) {
                    loadedLocations?.append(loadedLocation)
                    print("problems")
                }
            }
        }
    }
}

#Preview {
    AppView()
}
