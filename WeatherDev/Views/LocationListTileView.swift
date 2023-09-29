//
//  LocationListTileView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/27/23.
//

import SwiftUI

struct LocationListTileView: View {
    var location: Location
    var forecast: [Forecast]
    var todaysForecast: Forecast
    var isUserLocation: Bool
    @State private var locationSheet: Location?
    var body: some View {
        Button(action: {
            locationSheet = location
        }) {
            VStack(alignment: .leading, spacing: 1) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 1) {
                        Text("Forecast for")
                            .font(.system(size: 18))
                            .italic()
                        if isUserLocation {
                            Text("My Location")
                                .fontDesign(.serif)
                                .font(.title)
                        } else {
                            Text(location.city+", "+location.state)
                                .fontDesign(.serif)
                                .font(.title)
                        }
                    }
                    Spacer()
                        Image(systemName: todaysForecast.isDaytime ? "sun.max.fill" : "moon.fill")
                            .foregroundStyle(todaysForecast.isDaytime ? .sun : .moon)
                            .font(.system(size: 50))
                }
                HStack {
                    if isUserLocation {
                        Text(location.city+", "+location.state)
                            .fontDesign(.serif)
                            .italic()
                            .font(.system(size: 20))
                    }
                    Spacer()
                    Text(todaysForecast.name)
                        .font(.system(size: 18))
                        .fontDesign(.serif)
                }
                VStack(spacing: 1) {
                    Divider()
                        .frame(height: 1)
                        .overlay(.dividerLines)
                    HStack {
                        HStack(spacing: 0) {
                            Text(todaysForecast.isDaytime ? "High: " : "Low: ")
                                .font(.system(size: 15))
                                .fontDesign(.serif)
                            Text("\(todaysForecast.temperature)"+todaysForecast.temperatureUnit+"  ")
                                .font(.system(size: 18))
                        }
                        Divider()
                            .frame(width: 1)
                            .overlay(.dividerLines)
                        Spacer()
                        Text(todaysForecast.shortForecast)
                            .font(.system(size: 17))
                    }
                    .frame(height: 25)
                    Divider()
                        .frame(height: 1)
                        .overlay(.dividerLines)
                    HStack {
                        HStack(spacing: 0) {
                            Text("Wind: ")
                                .font(.system(size: 15))
                                .fontDesign(.serif)
                            Text(todaysForecast.windSpeed)
                                .font(.system(size: 17))
                            Text(" "+todaysForecast.windDirection)
                                .font(.system(size: 17))
                                .fontDesign(.serif)
                        }
                        Spacer()
                        Divider()
                            .frame(width: 1)
                            .overlay(.dividerLines)
                        Spacer()
                        HStack(spacing: 0) {
                            Text("Chance Rain: ")
                                .font(.system(size: 15))
                                .fontDesign(.serif)
                            Text("\(todaysForecast.probabilityOfPrecipitation)"+todaysForecast.probabilityOfPrecipitationUnit)
                                .font(.system(size: 18))
                        }
                    }
                    .frame(height: 25)
                    Divider()
                        .frame(height: 1)
                        .overlay(.dividerLines)
                }
            }
            .padding(6)
            .background(.locationListTile)
            .clipShape(.rect(cornerRadius: 8))
        }
        .fullScreenCover(item: $locationSheet) { location in
            NavigationStack {
                LocationWeatherView(location: location, forecast: forecast)
            }
        }
    }
}
