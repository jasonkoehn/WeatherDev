//
//  LocationStructs.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/11/23.
//

import Foundation
import SwiftData


struct SearchLocation: Identifiable {
    var id: UUID
    var city: String
    var latitude: Double
    var longitude: Double
    var state: String
    var country: String
}
