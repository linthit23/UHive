//
//  DayCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier: String = String(describing: DayCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        dateContainerView.roundCorners(radius: 15, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        dateContainerView.layer.shadowColor = UIColor.black.cgColor
        dateContainerView.layer.shadowOpacity = 0.25
        dateContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        dateContainerView.layer.shadowRadius = 1
        dateContainerView.layer.masksToBounds = false
        layer.masksToBounds = false
    }

}
