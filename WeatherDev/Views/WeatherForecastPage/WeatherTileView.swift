//
//  WeatherTileView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/27/23.
//

import SwiftUI

struct WeatherTileView: View {
    var period: Forecast
    @State var expand: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: period.icon)) {image in image.resizable()} placeholder: {ShimmerEffectAnimationView()}
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                VStack(alignment: .leading, spacing: 1) {
                    Text(period.name)
                        .font(.title)
                        .fontDesign(.serif)
                    Divider()
                        .frame(height: 1)
                        .overlay(.dividerLines)
                    HStack {
                        HStack(spacing: 0) {
                            Text(period.isDaytime ? "High: " : "Low: ")
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                            Text("\(period.temperature)"+period.temperatureUnit)
                                .font(.system(size: 20))
                        }
                        Spacer()
                        Divider()
                            .frame(width: 1)
                            .overlay(.dividerLines)
                        Spacer()
                        HStack(spacing: 0) {
                            Text("Chance Rain: ")
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                            Text("\(period.probabilityOfPrecipitation)"+period.probabilityOfPrecipitationUnit)
                                .font(.system(size: 20))
                        }
                    }
                    Divider()
                        .frame(height: 1)
                        .overlay(.dividerLines)
                    HStack(spacing: 0) {
                        Text("Wind: ")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                        Text(period.windSpeed)
                            .font(.system(size: 18))
                        Text(" "+period.windDirection)
                            .font(.system(size: 18))
                            .fontDesign(.serif)
                    }
                }
            }
            Divider()
                .frame(height: 1)
                .overlay(.dividerLines)
            if !expand {
                Text(period.shortForecast)
                    .font(.system(size: 18))
            }
            if expand {
                // Expanded View
                Text(period.detailedForecast)
                    .font(.system(size: 18))
                Divider()
                    .frame(height: 1)
                    .overlay(.dividerLines)
                HStack {
                    HStack(spacing: 0) {
                        Text("Dewpoint: ")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                        Text("\(period.dewpointTemperature)"+period.dewpointUnit)
                            .font(.system(size: 20))
                    }
                    Spacer()
                    Divider()
                        .frame(width: 1)
                        .overlay(.dividerLines)
                    Spacer()
                    HStack(spacing: 0) {
                        Text("Relative Humidity: ")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                        Text("\(period.relativeHumidity)"+period.relativeHumidityUnit)
                            .font(.system(size: 20))
                    }
                }
                Divider()
                    .frame(height: 1)
                    .overlay(.dividerLines)
                // Hourly Forecast
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(period.hourlyForecast) { period in
                            HourlyForecastTileView(period: period)
                        }
                    }
                    .padding(2)
                }
            }
        }
        .foregroundStyle(Color.primary)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.smooth) {
                expand.toggle()
            }
        }
        .padding(8)
        .background(period.isDaytime ? .daytime : .nighttime)
        .clipShape(.rect(cornerRadius: 10))
    }
}
