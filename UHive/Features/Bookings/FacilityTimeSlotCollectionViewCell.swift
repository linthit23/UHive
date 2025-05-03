//
//  FacilityTimeSlotCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class FacilityTimeSlotCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier: String = String(describing: FacilityTimeSlotCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            contentContainerView.backgroundColor = isSelected ? UIColor.primaryColor : UIColor.white
            timeLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
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
    
    func configure(with availablehour: AvailableHour) {
        timeLabel.text = availablehour.start.toHourMinute()
    }

}
