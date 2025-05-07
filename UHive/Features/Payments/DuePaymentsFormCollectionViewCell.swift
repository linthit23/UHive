//
//  DuePaymentsFormCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

class DuePaymentsFormCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DuePaymentsFormCollectionViewCellDelegate?

    static let reuseIdentifier: String = String(describing: DuePaymentsFormCollectionViewCell.self)
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postedDateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var paymentSlipImageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }
    
    func style() {
        submitButton.addDropShadow()
        submitButton.tintColor = .white
    }
    
    func configure(with reminder: PaymentReminderByIdResponse) {
        let userInfo = reminder.users.first
        postedDateLabel.text = "posted on " + (reminder.createdAt.toDisplayDate() ?? "")
        statusLabel.text = userInfo?.status.capitalizedFirstLetter()
        statusLabel.textColor = userInfo?.status.statusColor()
        if userInfo?.status == "PENDING" {
            submitButton.isHidden = true
        }
        dueDateLabel.text = reminder.dueDate.toDisplayDate() ?? ""
        invoiceLabel.text = userInfo?.invoice?.capitalized ?? "-"
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
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapSubmitButton(in: self)
        
    }
    
}

protocol DuePaymentsFormCollectionViewCellDelegate: AnyObject {
    func didTapSubmitButton(in cell: DuePaymentsFormCollectionViewCell)
}
