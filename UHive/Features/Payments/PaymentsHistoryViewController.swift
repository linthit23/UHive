//
//  PaymentsHistoryViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

class PaymentsHistoryViewController: UIViewController {
    
    var paymentReminderId: String!
    var reminderDetail: PaymentReminderByIdResponse?
    
    @IBOutlet weak var paymentsHistoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentsHistoryCollectionView.delegate = self
        paymentsHistoryCollectionView.dataSource = self
        paymentsHistoryCollectionView.register(UINib(nibName: PaymentsHistoryFormCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: PaymentsHistoryFormCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        fetchPaymentReminderDetails()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let layout = paymentsHistoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}
    
    func fetchPaymentReminderDetails() {
        PaymentService().fetchPaymentReminderById(id: paymentReminderId) { [weak self] reminder in
            guard let self = self, let reminder = reminder else {
                print("Failed to fetch reminder details")
                return
            }
            self.reminderDetail = reminder
            DispatchQueue.main.async {
                self.paymentsHistoryCollectionView.reloadData()
            }
        }
    }



}

extension PaymentsHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentsHistoryFormCollectionViewCell.reuseIdentifier, for: indexPath) as? PaymentsHistoryFormCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let reminder = reminderDetail {
            cell.configure(with: reminder)
        }
        return cell
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-32, height: collectionView.frame.height)
    }
    
    
}


