//
//  HistoryViewController.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!


    // MARK: - Private Properties
    private var visitedLocations = [VisitedLocation]()

    // MARK: - Viewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        visitedLocations = PersistenceManager.getVisitedLocations()
        tableView.reloadData()
    }



    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitedLocations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
        cell.setup(visitedLocation: visitedLocations[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let visitedLocation = visitedLocations[indexPath.row]

        guard let controller = storyboard?.instantiateViewController(withIdentifier: String(describing: VisitedLocationViewController.self)) as? VisitedLocationViewController else { return }
        controller.visitedLocation = visitedLocation
        present(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, nil) in
            guard let self = self else { return }
            PersistenceManager.deleteVisitedLocation(withId: self.visitedLocations[indexPath.row].id)
            DispatchQueue.main.async {
                self.visitedLocations = PersistenceManager.getVisitedLocations()
                tableView.reloadData()
            }
        }
        delete.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }

}
