//
//  WeatherView.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/13/23.
//

import SwiftUI

struct WeatherView: View {
    @Environment(\.dismiss) private var dismiss
    var name: String
    var state: String
    var forecast: [Forecast]
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(forecast, id: \.number) { period in
                        WeatherTileView(period: period)
                    }
                }
            }
        }
        .navigationTitle(name+", "+state)
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
