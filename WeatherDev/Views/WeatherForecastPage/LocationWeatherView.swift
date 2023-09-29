//
//  LocationWeatherView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/27/23.
//

import SwiftUI

struct LocationWeatherView: View {
    @Environment(\.dismiss) private var dismiss
    var location: Location
    var forecast: [Forecast]
    @State var showAFD: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                // Area Forcast Discussion
                Button(action: {
                    showAFD.toggle()
                }) {
                    HStack {
                        Text("Area Forecast Discussion")
                            .font(.title2)
                            .fontDesign(.serif)
                            .foregroundStyle(Color.primary)
                        Spacer()
                    }
                    .padding(8)
                    .background(Color(.systemGray4))
                    .clipShape(.rect(cornerRadius: 10))
                }
                
                // Weather Periods
                ForEach(forecast) { period in
                    WeatherTileView(period: period)
                }
            }
            .padding(.horizontal, 10)
        }
        .navigationTitle(location.city+", "+location.state)
        .sheet(isPresented: $showAFD) {
            NavigationStack {
                ForecastDiscussionView(discussion: location.forecastDiscussion)
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "list.bullet")
                    })
                }
            }
        }
    }
}
