//
//  MyBookingsCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class MyBookingsCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier: String = String(describing: MyBookingsCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var facilityNameLabel: UILabel!
    @IBOutlet weak var bookedCapacityLabel: UILabel!
    @IBOutlet weak var bookingStatusLabel: UILabel!
    @IBOutlet weak var bookedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        contentContainerView.roundCorners(radius: 18, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        
        contentContainerView.layer.shadowColor = UIColor.black.cgColor
        contentContainerView.layer.shadowOpacity = 0.25
        contentContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentContainerView.layer.shadowRadius = 1
        contentContainerView.layer.masksToBounds = false
        layer.masksToBounds = false
    }

    func configure(with booking: FacilityBooking) {
        switch booking.facility.name {
        case "Basketball Court":
            iconImageView.image = UIImage(systemName: "basketball")
        default: break
        }
        facilityNameLabel.text = booking.facility.name
        if booking.numberOfPeople == 1 {
            bookedCapacityLabel.text = "\(booking.numberOfPeople) person"
        } else {
            bookedCapacityLabel.text = "\(booking.numberOfPeople) persons"
        }
        bookingStatusLabel.text = booking.status.capitalizedFirstLetter()
        bookingStatusLabel.textColor = booking.status.statusColor()
        bookedDateLabel.text = booking.createdAt.toFormattedDateAndTimeString()
    }
}
