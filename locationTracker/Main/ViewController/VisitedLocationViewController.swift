//
//  VisitedLocationViewController.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import UIKit
import MapKit

class VisitedLocationViewController: UIViewController, MKMapViewDelegate {

    // MARK: - Properties
    var visitedLocation: VisitedLocation?

    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonBackgroundView: UIView!

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupViews()
    }
    

    // MARK: - IBOutlets
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    // MARK: - Methods
    func showVisitedLocation(_ location: VisitedLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.location.coordinates.lat,
                                                longitude: location.location.coordinates.long)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)

        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = location.location.name
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
    }


    // MARK: - Private Methods
    private func setupViews() {
        buttonBackgroundView.layer.cornerRadius = 22
        buttonBackgroundView.clipsToBounds = true

        mapView.updateFocusIfNeeded()
        mapView.pointOfInterestFilter = .includingAll
        guard let visitedLocation = visitedLocation else { return }
        showVisitedLocation(visitedLocation)
    }
}
