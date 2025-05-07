//
//  FacilityCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class FacilityCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: FacilityCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        iconImageView.tintColor = .primaryApp
        contentContainerView.roundCorners(radius: 18, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        
        contentContainerView.layer.shadowColor = UIColor.black.cgColor
        contentContainerView.layer.shadowOpacity = 0.25
        contentContainerView.layer.shadowOffset = .zero
        contentContainerView.layer.shadowRadius = 1
        contentContainerView.layer.masksToBounds = false
        layer.masksToBounds = false
    }

    func configure(with facility: Facility) {
        switch facility.name {
        case "Main Library":
            iconImageView.image = UIImage(systemName: "books.vertical")
        case "Computer Lab A":
            iconImageView.image = UIImage(systemName: "desktopcomputer")
        case "Physics Lab":
            iconImageView.image = UIImage(systemName: "atom")
        case "Chemistry Lab":
            iconImageView.image = UIImage(systemName: "flask")
        case "Auditorium":
            iconImageView.image = UIImage(systemName: "music.note.house")
        case "Sports Complex":
            iconImageView.image = UIImage(systemName: "figure.run")
        case "Meeting Room 101":
            iconImageView.image = UIImage(systemName: "person.2.square.stack")
        case "Study Room 1":
            iconImageView.image = UIImage(systemName: "book.closed")
        case "Language Lab":
            iconImageView.image = UIImage(systemName: "mic.fill")
        case "Art & Design Studio":
            iconImageView.image = UIImage(systemName: "paintpalette.fill")
        default: break
        }
        titleLabel.text = facility.name
    }
}
