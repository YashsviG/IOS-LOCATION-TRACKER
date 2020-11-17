//
//  GeocoderManager.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import Foundation
import CoreLocation

class GeocoderManager {

    // MARK: - Properties
    static let shared = GeocoderManager()


    // MARK: - Private Properties
    private var glGeocoder: CLGeocoder?


    // MARK: - Init
    init() {
        setupGeocoderManager()
    }

    func getLocationFromClLocation(clLocation: CLLocation, completion: @escaping (Result<Location, Error>) -> Void) {
        glGeocoder?.reverseGeocodeLocation(clLocation) { placemarks, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let placeDetails = placemarks?.first,
                let name = placeDetails.name,
                let city = placeDetails.locality,
                let streetAddress = placeDetails.thoroughfare else {
                    return
            }
            let address = Address(city: city, street: streetAddress)
            let location = Location(name: name,
                                    coordinates: Coordinates(lat: clLocation.coordinate.latitude,
                                                             long: clLocation.coordinate.longitude),
                                    address: address)
            completion(.success(location))
        }
    }

    // MARK: - Private Methods
    private func setupGeocoderManager() {
        glGeocoder = CLGeocoder()
    }
}
