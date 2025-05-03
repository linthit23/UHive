//
//  BookedFacilityFormCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class BookedFacilityFormCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier: String = String(describing: BookedFacilityFormCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var facilityPictureImageView: UIImageView!
    @IBOutlet weak var facilityNameLabel: UILabel!
    @IBOutlet weak var facilityBookingDateLabel: UILabel!
    @IBOutlet weak var facilityBookingTimeSlotLabel: UILabel!
    @IBOutlet weak var facilityBookingNumberOfPeopleLabel: UILabel!
    @IBOutlet weak var facilityBookingStatusLabel: UILabel!
    @IBOutlet weak var facilityBookingReasonForUseLabel: UILabel!
    @IBOutlet weak var facilityBookingCancelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        facilityBookingCancelButton.addDropShadow()
        facilityBookingCancelButton.tintColor = .white
    }
    
    func configure(with booking: FacilityBooking) {
        facilityNameLabel.text = booking.facility.name
        facilityBookingDateLabel.text = booking.start.toDisplayDate()
        facilityBookingTimeSlotLabel.text = "\(booking.start.toHourMinute() ?? "") - \(booking.end.toHourMinute() ?? "")"
        if booking.numberOfPeople == 1 {
            facilityBookingNumberOfPeopleLabel.text = "\(booking.numberOfPeople) person"
        } else {
            facilityBookingNumberOfPeopleLabel.text = "\(booking.numberOfPeople) persons"
        }
        facilityBookingStatusLabel.text = booking.status.capitalizedFirstLetter()
        facilityBookingStatusLabel.textColor = booking.status.statusColor()
        facilityBookingReasonForUseLabel.text = booking.reason
    }

}
