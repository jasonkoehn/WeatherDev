//
//  LocationSearchResultsView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/11/23.
//

import SwiftUI

struct LocationSearchResultsView: View {
    @Environment(\.dismissSearch) private var dismissSearch
    @EnvironmentObject var locationSearchModel: LocationSearchModel
    @State var newLocation: SearchLocation? = nil
    var body: some View {
        if locationSearchModel.fetchedPlace != nil {
            List {
                if let place = locationSearchModel.fetchedPlace {
                    Button(action: {
                        newLocation = SearchLocation(id: place.id, city: place.city, latitude: place.latitude, longitude: place.longitude, state: place.state, country: place.country)
                    }) {
                        Text(place.city+", "+place.state+" "+place.country)
                    }
                }
            }
            .listStyle(.plain)
            .sheet(item: $newLocation) { location in
                NavigationStack {
                    NewLocationView(dismissSearch: _dismissSearch, city: location.city, latitude: location.latitude, longitude: location.longitude, state: location.state)
                }
            }
        } else {
            Text("No Results")
                .font(.title)
        }
    }
}
