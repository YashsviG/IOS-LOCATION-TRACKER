//
//  LocationTableViewCell.swift
//  locationTracker
//
//  Created by Yashsvi Girdhar on 17/11/2020.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    var visitedLocation: VisitedLocation?

    // MARK: - IBOUtlets
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationDetailsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(visitedLocation: VisitedLocation) {
        locationNameLabel.text = visitedLocation.location.name
        locationDetailsLabel.text = visitedLocation.location.address.street
    }

}
