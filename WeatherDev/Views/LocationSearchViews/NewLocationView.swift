//
//  NewLocationView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/27/23.
//

import SwiftUI
import SwiftData

struct NewLocationView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.modelContext) private var context
    @Environment var dismissSearch: DismissSearchAction
    @Environment(\.dismiss) var dismiss
    @Query private var locations: [Location]
    var city: String
    var state: String
    var latitude: Double
    var longitude: Double
    @State var location: Location = Location()
    var body: some View {
        ScrollView {
            VStack {
                Text(city)
                Text(state)
                ForEach(location.forecast) { period in
                    Text("\(period.temperature)")
                }
            }
        }
        .task {
            if let locationInfo = await dataManager.locationUrlsRequest(latitude: latitude, longitude: longitude) {
                location.city = city
                location.state = state
                location.officeId = locationInfo.gridId
                location.dailyForecastUrl = locationInfo.forecast
                location.hourlyForecastUrl = locationInfo.forecastHourly
            }
            location.forecast = await dataManager.forecastUrlRequest(url: location.dailyForecastUrl)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
//                if location.forecast != [] {
                    Button(action: {
                        let newSortNumber = locations.count + 1
                        location.sortOrder = newSortNumber
                        context.insert(location)
                        dismissSearch()
                        dismiss()
                    }, label: {
                        Text("Add")
                    })
//                } else {
//                    Text("Add")
//                        .foregroundStyle(.gray)
//                }
            }
        }
    }
}
