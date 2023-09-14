//
//  NewLocationView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/12/23.
//

import SwiftUI
import SwiftData

struct NewLocationView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.modelContext) private var context
    @Environment var dismissSearch: DismissSearchAction
    @Environment(\.dismiss) var dismiss
    var city: String
    var latitude: Double
    var longitude: Double
    var state: String
    @State var locationInfo: LocationUrlModel? = nil
    var body: some View {
        VStack {
            Text(city)
            Text(state)
            if let location = locationInfo {
                Text(location.gridId)
                Text(location.forecast)
                Text(location.forecastHourly)
            }
        }
        .task {
            locationInfo = await dataManager.getLocationUrlsRequest(latitude: latitude, longitude: longitude)
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
                if let locationInfo = locationInfo {
                    Button(action: {
                        let location = Location(name: city, state: state, officeId: locationInfo.gridId, dailyForecastUrl: locationInfo.forecast, hourlyForecastUrl: locationInfo.forecastHourly)
                        context.insert(location)
                        dismissSearch()
                        dismiss()
                    }, label: {
                        Text("Add")
                    })
                } else {
                    Text("Add")
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}
