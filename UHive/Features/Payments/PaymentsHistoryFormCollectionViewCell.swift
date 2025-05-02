//
//  PaymentsHistoryFormCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit
import SDWebImage

class PaymentsHistoryFormCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier: String = String(describing: PaymentsHistoryFormCollectionViewCell.self)
        
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var titleLabeL: UILabel!
    @IBOutlet weak var processedDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var paymentSlipImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }
    
    func style() {
        
    }
    
    func configure(with reminder: PaymentReminderByIdResponse) {
        let userInfo = reminder.users.first
        
//        titleLabeL.text =
        processedDateLabel.text = "processed on " + (reminder.updatedAt.toDisplayDate() ?? "")
        statusLabel.text = userInfo?.status.capitalizedFirstLetter()
        statusLabel.textColor = userInfo?.status.statusColor()
        dueDateLabel.text = reminder.dueDate.toDisplayDate() ?? ""
        invoiceLabel.text = userInfo?.invoice?.capitalized ?? ""
        amountLabel.text = "\(reminder.amount)$"
        if let slipUrlString = userInfo?.slip, let url = URL(string: slipUrlString) {
            paymentSlipImageView.sd_setImage(with: url, placeholderImage: UIImage().withTintColor(.grey))
        } else {
            paymentSlipImageView.image = UIImage().withTintColor(.grey)
        }
        paymentSlipImageView.contentMode = .scaleAspectFill
        paymentSlipImageView.layer.cornerRadius = 8
        paymentSlipImageView.clipsToBounds = true
    }

}
