//
//  MapViewController.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var appSwitch: UISegmentedControl!


    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupMap()
        LocationManager.shared.requestAuthorization()
        NotificationManager.shared.requestAuthorization()
    }
    
    @IBAction func appSwitchValueChanged(_ sender: Any) {
        LocationManager.shared.shouldCreateFakeVisits = (appSwitch.selectedSegmentIndex == 0 ? false : true)
    }

    // MARK: - Private Methods
    private func setupMap() {
        mapView.showsUserLocation = true
        mapView.pointOfInterestFilter = .includingAll
        mapView.updateFocusIfNeeded()

        LocationManager.shared.didUpdateLocation = { [weak self] location in
            guard let self = self else { return }
            self.render(location)
        }
    }

    private func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)
        mapView.setRegion(region, animated: true)
    }

}
