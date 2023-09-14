//
//  WeatherLocationsView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/11/23.
//

import SwiftUI
import SwiftData

struct WeatherLocationsView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.modelContext) private var context
    @Query private var locations: [Location]
    @Binding var loadedUserLocation: LoadedLocation?
    @Binding var loadedLocations: [LoadedLocation]?
    @State var locationView: LoadedLocation? = nil
    var body: some View {
        List {
            if let userLocation = loadedUserLocation {
                Button(action: {
                    locationView = userLocation
                }, label: {
                    LocationTileView(location: userLocation, forecast: userLocation.forecast.first!)
                })
                .listRowSeparator(.hidden)
            }
            if let loadedLocations = loadedLocations {
                ForEach(loadedLocations) { location in
                    Button(action: {
                        locationView = location
                    }, label: {
                        LocationTileView(location: location, forecast: location.forecast.first!)
                    })
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        context.delete(locations[index])
                    }
                })
            }
        }
        .listStyle(.plain)
        .toolbar {
            EditButton()
        }
        .fullScreenCover(item: $locationView) { location in
            NavigationStack {
                WeatherView(name: location.name, state: location.state, forecast: location.forecast)
            }
        }
    }
}
