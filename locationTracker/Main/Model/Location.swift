//
//  Location.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import Foundation

struct Location {
    let name: String
    let coordinates: Coordinates
    let address: Address
}

struct Coordinates {
    let lat: Double
    let long: Double
}

struct Address {
    let city: String
    let street: String
}
