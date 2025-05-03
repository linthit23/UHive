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
        statusContainerView.isHidden = true
        statusLabel.isHidden = true
    }
    
    func configure(with session: Class) {
        timeLabel.text = session.start.toTimeString()
        classNameLabel.text = session.subject
        roomNumberLabel.text = "Room \(session.room)"
        lecturerNameLabel.text = session.instructor
        
        self.alpha = 1.0
        currentClassIndicatorImageView.image = UIImage(systemName: "circle")
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let sessionDate = isoFormatter.date(from: session.start) else {
            print("Invalid date format")
            return
        }
        
        let now = Date()
        let calendar = Calendar.current
        
        if calendar.isDate(sessionDate, equalTo: now, toGranularity: .hour) {
            currentClassIndicatorImageView.image = UIImage(systemName: "circle.fill")
        } else if sessionDate < now {
            currentClassIndicatorImageView.image = UIImage(systemName: "checkmark.circle")
        } else {
            currentClassIndicatorImageView.image = UIImage(systemName: "circle.dashed")
        }
        
    }

}
