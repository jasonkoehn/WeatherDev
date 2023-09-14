//
//  LocationTileView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/14/23.
//

import SwiftUI

struct LocationTileView: View {
    var location: LoadedLocation
    var forecast: Forecast
    var body: some View {
        ZStack {
            if forecast.isDaytime {
                Color.daytime
                    .clipShape(.rect(cornerRadius: 8))
            } else {
                Color.nighttime
                    .clipShape(.rect(cornerRadius: 8))
            }
            VStack(spacing: 1) {
                HStack {
                    Text(location.name+", "+location.state)
                        .font(.title2)
                    Spacer()
                    Text("\(forecast.temperature)"+forecast.temperatureUnit)
                        .font(.title2)
                }
                HStack {
                    AsyncImage(url: URL(string: forecast.icon)) {image in image.resizable()} placeholder: {ShimmerEffectAnimationView()}
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                    Spacer()
                    Text("\(forecast.windSpeed)"+" "+forecast.windDirection)
                        .font(.title2)
                }
            }
            .padding(10)
        }
    }
}
