//
//  PaymentsViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class PaymentsViewController: UIViewController {

    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var paymentsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var paymentsCollectionView: UICollectionView!
    
    private var duePayments: [PaymentReminder] = []
    private var paymentHistory: [PaymentReminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentsCollectionView.delegate = self
        paymentsCollectionView.dataSource = self
        paymentsCollectionView.register(UINib(nibName: DuePaymentsCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: DuePaymentsCollectionViewCell.reuseIdentifier)
        paymentsCollectionView.register(UINib(nibName: PaymentsHistoryCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: PaymentsHistoryCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalVC))
        closeImageView.isUserInteractionEnabled = true
        closeImageView.addGestureRecognizer(tapGesture)
        
        paymentsSegmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        fetchPaymentReminders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        fetchPaymentReminders()
    }
    
    func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let layout = paymentsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}
    
    @objc func dismissModalVC() {
        self.dismiss(animated: true)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        let _ = sender.selectedSegmentIndex
        fetchPaymentReminders()
    }
    
    func openDuePaymentsVC(_ indexPath: IndexPath) {
        let duePaymentsVC = DuePaymentsViewController()
        duePaymentsVC.paymentReminderId = self.duePayments[indexPath.row].id
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(duePaymentsVC, animated: true)
    }
    
    func openPaymentsHistoryVC(_ indexPath: IndexPath) {
        let paymentsHistoryVC = PaymentsHistoryViewController()
        paymentsHistoryVC.paymentReminderId = self.paymentHistory[indexPath.row].id
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(paymentsHistoryVC, animated: true)
    }
    
    func fetchPaymentReminders() {
        PaymentService().fetchAllPaymentReminders { [weak self] paymentReminderResponse in
            guard let self = self, let paymentReminders = paymentReminderResponse?.data else {
                print("Failed to load payment reminders")
                return
            }
            
            self.duePayments = paymentReminders.filter { $0.status == "PENDING" || $0.status == "UNPAID" }
            self.paymentHistory = paymentReminders.filter { $0.status == "PAID" }
            
            DispatchQueue.main.async {
                self.paymentsCollectionView.reloadData()
            }
        }
    }

}

extension PaymentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch paymentsSegmentedControl.selectedSegmentIndex {
        case 0:
            openDuePaymentsVC(indexPath)
        case 1:
            openPaymentsHistoryVC(indexPath)
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch paymentsSegmentedControl.selectedSegmentIndex {
        case 0: return duePayments.count
        case 1: return paymentHistory.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch paymentsSegmentedControl.selectedSegmentIndex {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DuePaymentsCollectionViewCell.reuseIdentifier, for: indexPath) as? DuePaymentsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let reminder = duePayments[indexPath.item]
            cell.configure(with: reminder)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentsHistoryCollectionViewCell.reuseIdentifier, for: indexPath) as? PaymentsHistoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let reminder = paymentHistory[indexPath.item]
            cell.configure(with: reminder)
            return cell
        default :
            return UICollectionViewCell()
        }
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch paymentsSegmentedControl.selectedSegmentIndex {
        case 0:
            return UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        case 1:
            return UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        default: return UIEdgeInsets()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch paymentsSegmentedControl.selectedSegmentIndex {
        case 0:
            return 10
        case 1:
            return 10
        default: return CGFloat()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch paymentsSegmentedControl.selectedSegmentIndex {
        case 0:
            return 10
        case 1:
            return 10
        default: return CGFloat()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch paymentsSegmentedControl.selectedSegmentIndex {
        case 0:
            let padding: CGFloat = 10
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 1
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 100)
        case 1:
            let padding: CGFloat = 10
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 1
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 100)
        default: return CGSize.zero
        }
    }
    
}
