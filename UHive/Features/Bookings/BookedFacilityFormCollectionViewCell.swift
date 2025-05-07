//
//  BookedFacilityFormCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class BookedFacilityFormCollectionViewCell: UICollectionViewCell {

    weak var delegate: BookedFacilityFormCollectionViewCellDelegate?
    
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
        switch booking.facility.name {
        case "Main Library":
            facilityPictureImageView.image = UIImage(systemName: "books.vertical")
        case "Computer Lab A":
            facilityPictureImageView.image = UIImage(systemName: "desktopcomputer")
        case "Physics Lab":
            facilityPictureImageView.image = UIImage(systemName: "atom")
        case "Chemistry Lab":
            facilityPictureImageView.image = UIImage(systemName: "flask")
        case "Auditorium":
            facilityPictureImageView.image = UIImage(systemName: "music.note.house")
        case "Sports Complex":
            facilityPictureImageView.image = UIImage(systemName: "figure.run")
        case "Meeting Room 101":
            facilityPictureImageView.image = UIImage(systemName: "person.2.square.stack")
        case "Study Room 1":
            facilityPictureImageView.image = UIImage(systemName: "book.closed")
        case "Language Lab":
            facilityPictureImageView.image = UIImage(systemName: "mic.fill")
        case "Art & Design Studio":
            facilityPictureImageView.image = UIImage(systemName: "paintpalette.fill")
        default: break
        }
        if booking.facility.name == "Art & Design Studio" {
            facilityNameLabel.text = "Art Studio"
        } else {
            facilityNameLabel.text = booking.facility.name
        }
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
        if booking.status != "PENDING" {
            facilityBookingCancelButton.isHidden = true
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        delegate?.didTapCancelButton(in: self)
    }

}

protocol BookedFacilityFormCollectionViewCellDelegate: AnyObject {
    func didTapCancelButton(in cell: BookedFacilityFormCollectionViewCell)
}
