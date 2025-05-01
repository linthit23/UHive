//
//  ClassesCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

class ClassesCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: ClassesCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var currentClassIndicatorImageView: UIImageView!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var lecturerNameLabel: UILabel!
    @IBOutlet weak var statusContainerView: UIView!
    @IBOutlet weak var statusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        statusContainerView.roundCorners(radius: 9, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
    }

}
