//
//  NotificationManager.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import Foundation
import UserNotifications

class NotificationManager {

    // MARK: - Properties
    static let shared = NotificationManager()


    // MARK: - Private Properties
    private var center = UNUserNotificationCenter.current()


    // MARK: - Methods
    func sendNewVisitedLocationNotification(visitedLocation: VisitedLocation) {
        // 1
        let content = UNMutableNotificationContent()
        content.title = "New Location entry 📌"
        content.body = "A visit of \(visitedLocation.location.name) was just registered!"
        content.sound = .default

        // 2
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: visitedLocation.id.uuidString, content: content, trigger: trigger)

        // 3
        center.add(request, withCompletionHandler: nil)
    }

    func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound],
                                    completionHandler: { granted, error in
                                        guard granted else { return }
                                    })
    }
}
