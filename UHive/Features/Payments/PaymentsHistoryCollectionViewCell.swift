//
//  PaymentsHistoryCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class PaymentsHistoryCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier: String = String(describing: PaymentsHistoryCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var processedDateLabel: UILabel!
    
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
    
    func configure(with reminder: PaymentReminder) {
//        titleLabel.text =
        statusLabel.text = reminder.status.capitalizedFirstLetter()
        statusLabel.textColor = reminder.status.statusColor()
        processedDateLabel.text = "processed on " + (reminder.updatedAt.toDisplayDate() ?? "")
    }

}
