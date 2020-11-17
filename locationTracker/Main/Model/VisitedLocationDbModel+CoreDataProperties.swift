//
//  VisitedLocationDbModel+CoreDataProperties.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//
//

import Foundation
import CoreData


extension VisitedLocationDbModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VisitedLocationDbModel> {
        return NSFetchRequest<VisitedLocationDbModel>(entityName: "VisitedLocationDbModel")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var date: Date
    @NSManaged public var street: String
    @NSManaged public var city: String
    @NSManaged public var lat: Double
    @NSManaged public var long: Double

}
