//
//  UIViewController+Alert.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import UIKit

extension UIViewController {
    func displayError(_ error: Error) {
        let alertController = UIAlertController(
            title: "An error Occured",
            message: error.localizedDescription,
            preferredStyle: .alert
        )

        alertController.addAction(
            UIAlertAction(
                title: "Dismiss",
                style: .destructive,
                handler: nil
            )
        )

        present(alertController, animated: true, completion: nil)
    }
}
