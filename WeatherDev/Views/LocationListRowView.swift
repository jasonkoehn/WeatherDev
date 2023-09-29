//
//  LocationListRowView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/27/23.
//

import SwiftUI

struct LocationListRowView: View {
    var location: Location
    @State var forecast: [Forecast] = []
    var body: some View {
        VStack {
            if forecast != [] {
                LocationListTileView(location: location, forecast: forecast, todaysForecast: forecast.first!, isUserLocation: false)
            } else {
                Text("Loading...")
            }
        }
        .task {
            var forecasts = location.forecast
            forecasts.sort {
                $0.number < $1.number
            }
            forecast = forecasts
        }
    }
}
