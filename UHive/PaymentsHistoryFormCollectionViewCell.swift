//
//  PaymentsHistoryFormCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

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

}
