//
//  FakeVisit.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import Foundation
import CoreLocation

class FakeVisit: CLVisit {
  private let myCoordinates: CLLocationCoordinate2D
  private let myArrivalDate: Date
  private let myDepartureDate: Date

  override var coordinate: CLLocationCoordinate2D {
    return myCoordinates
  }

  override var arrivalDate: Date {
    return myArrivalDate
  }

  override var departureDate: Date {
    return myDepartureDate
  }

  init(coordinates: CLLocationCoordinate2D, arrivalDate: Date, departureDate: Date) {
    myCoordinates = coordinates
    myArrivalDate = arrivalDate
    myDepartureDate = departureDate
    super.init()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
