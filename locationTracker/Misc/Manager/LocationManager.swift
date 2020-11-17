//
//  LocationManager.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import Foundation
import CoreLocation

class LocationManager: NSObject,CLLocationManagerDelegate {

    // MARK: - Properties
    static let shared = LocationManager()
    var didUpdateLocation: ((CLLocation) -> Void)?
    var shouldCreateFakeVisits = false

    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }


    // MARK: - Private Properties
    private var clLocationManager: CLLocationManager?


    // MARK: - Init
    override init() {
        super.init()
        setupLocationManager()
    }


    // MARK: - Methods
    func requestAuthorization() {
        if authorizationStatus != .authorizedAlways {
            clLocationManager?.requestAlwaysAuthorization()
        }
    }


    // MARK: - Private Methods
    private func setupLocationManager() {
        clLocationManager = CLLocationManager()
        clLocationManager?.desiredAccuracy = kCLLocationAccuracyBest
        clLocationManager?.distanceFilter = 3
        clLocationManager?.allowsBackgroundLocationUpdates = true
        clLocationManager?.pausesLocationUpdatesAutomatically = false
        clLocationManager?.startMonitoringVisits()
        clLocationManager?.startUpdatingLocation()
        clLocationManager?.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        let clLocation = CLLocation(latitude: visit.coordinate.latitude,
                                    longitude: visit.coordinate.longitude)

        GeocoderManager.shared.getLocationFromClLocation(clLocation: clLocation) {  result in
            switch result {
            case .success(let location):
                let visitedLocation = VisitedLocation(id: UUID(),
                                                      date: visit.arrivalDate,
                                                      location: location)
                PersistenceManager.saveVisitedLocation(visitedLocation: visitedLocation)

            case .failure: return
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        didUpdateLocation?(location)

        if shouldCreateFakeVisits {
            GeocoderManager.shared.getLocationFromClLocation(clLocation: location) {  result in
                switch result {
                case .success(let location):
                    let visitedLocation = VisitedLocation(id: UUID(),
                                                          date: Date(),
                                                          location: location)
                    PersistenceManager.saveVisitedLocation(visitedLocation: visitedLocation)

                case .failure: return
                }
            }
        }
    }

}
