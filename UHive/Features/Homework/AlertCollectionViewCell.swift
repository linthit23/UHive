//
//  AlertCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

class AlertCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: AlertCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var alertNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var countDownNumberLabel: UILabel!
    @IBOutlet weak var countDownHoursLabel: UILabel!
    
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
    
    func configure(with test: Test) {
        alertNameLabel.text = test.content
        dueDateLabel.text = test.dueDate.toDisplayDate()
        
        if isFutureDate(test.dueDate) {
            countDownNumberLabel.isHidden = false
            countDownHoursLabel.isHidden = false
            if let dayDiff = daysBetweenTodayAnd(test.dueDate) {
                countDownNumberLabel.text = "\(dayDiff)"
                if dayDiff > 1 {
                    countDownHoursLabel.text = "days left"
                } else {
                    countDownHoursLabel.text = "day left"
                }
                switch dayDiff {
                case 0:
                    countDownNumberLabel.textColor = .gray
                    countDownHoursLabel.textColor = .gray
                case 1:
                    countDownNumberLabel.textColor = .red
                    countDownHoursLabel.textColor = .red
                case 2:
                    countDownNumberLabel.textColor = .orange
                    countDownHoursLabel.textColor = .orange
                default:
                    countDownNumberLabel.textColor = .systemGreen
                    countDownHoursLabel.textColor = .systemGreen
                }
            }
        } else {
            countDownNumberLabel.textColor = .primaryApp
            countDownHoursLabel.textColor = .primaryApp
            countDownHoursLabel.text = "/100"
            countDownNumberLabel.text = "75"
        }
    }
    
    func isFutureDate(_ isoDateString: String) -> Bool {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = dateFormatter.date(from: isoDateString) {
            return date > Date()
        }
        return false
    }
    
    func daysBetweenTodayAnd(_ isoDateString: String) -> Int? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let inputDate = dateFormatter.date(from: isoDateString) else {
            return nil // Invalid date string
        }
        
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfInputDate = calendar.startOfDay(for: inputDate)
        
        let components = calendar.dateComponents([.day], from: startOfToday, to: startOfInputDate)
        return components.day
    }


}
