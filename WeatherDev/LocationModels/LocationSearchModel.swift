//
//  LocationSearchModel.swift
//  WeatherDev
//
//  Created by Jason Koehn on 9/11/23.
//

import Foundation
import MapKit
import Combine

class LocationSearchModel: NSObject, ObservableObject {
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlace: SearchLocation?
    
    override init() {
        super .init()
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != "" {
                    self.getCities(value: value)
                } else {
                    self.fetchedPlace = nil
                }
            })
    }
    
    func getCities(value: String) {
        self.getCoordinate(addressString: value) { coordinate, place, error in
            // Can get other items like address and zipcode if needed
            if place?.locality != "" && place?.country == "United States" {
                self.fetchedPlace = SearchLocation(id: UUID(), city: place?.locality ?? "", latitude: coordinate.latitude, longitude: coordinate.longitude, state: place?.administrativeArea ?? "", country: place?.country ?? "")
            }
        }
    }
    
    func getCoordinate( addressString : String, completionHandler: @escaping(CLLocationCoordinate2D, CLPlacemark?, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                
                if let placemark = placemarks?[0] {
                    
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, placemark, nil)
                    
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, nil, error as NSError?)
        }
    }
}
