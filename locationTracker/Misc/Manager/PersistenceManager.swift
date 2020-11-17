//
//  PersistenceManager.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import Foundation
import CoreData

class PersistenceManager {

    // MARK: - Properties
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "locationTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Private Properties
    private static let fetchRequest: NSFetchRequest<VisitedLocationDbModel> = VisitedLocationDbModel.fetchRequest()

    
    // MARK: - Init
      private init() {}


    // MARK: - Methods
    static func saveVisitedLocation(visitedLocation: VisitedLocation) {
        let visitedLocationDbEntry = VisitedLocationDbModel(context: PersistenceManager.context)
        visitedLocationDbEntry.date = visitedLocation.date
        visitedLocationDbEntry.name = visitedLocation.location.name
        visitedLocationDbEntry.lat = visitedLocation.location.coordinates.lat
        visitedLocationDbEntry.long = visitedLocation.location.coordinates.long
        visitedLocationDbEntry.street = visitedLocation.location.address.street
        visitedLocationDbEntry.city = visitedLocation.location.address.city
        visitedLocationDbEntry.id = visitedLocation.id
        PersistenceManager.saveContext()
        NotificationManager.shared.sendNewVisitedLocationNotification(visitedLocation: visitedLocation)
    }

    static func getVisitedLocations() -> [VisitedLocation] {

        do {
            let dBLocations = try context.fetch(fetchRequest)
            let visitedLocations = dBLocations.map {
                VisitedLocation(id: $0.id,
                                date: $0.date,
                                location: Location(name: $0.name,
                                                   coordinates: Coordinates(lat: $0.lat, long: $0.long),
                                                   address: Address(city: $0.city,street: $0.street)))
            }

            return visitedLocations
        } catch{
            fatalError()
        }
    }

    static func deleteVisitedLocation(withId id: UUID) {
        do {
            let visitedLocations = try context.fetch(fetchRequest)
            visitedLocations.forEach { if $0.id == id { context.delete($0)}}
            try context.save()
            
        } catch _ {
            // error handling
        }
    }

    /// Helper Method to nuke databse
    static func deleteAllEntries() {
        do {
            let visitedLocations = try context.fetch(fetchRequest)
            visitedLocations.forEach { context.delete($0) }

            try context.save()
        } catch _ {
            // error handling
        }
    }


    // MARK: - Core Data Saving support
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
