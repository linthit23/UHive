//
//  DuePaymentsViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

class DuePaymentsViewController: UIViewController {
    
    var paymentReminderId: String!
    var reminderDetail: PaymentReminderByIdResponse?

    @IBOutlet weak var duePaymentsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        duePaymentsCollectionView.delegate = self
        duePaymentsCollectionView.dataSource = self
        duePaymentsCollectionView.register(UINib(nibName: DuePaymentsFormCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: DuePaymentsFormCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        fetchPaymentReminderDetails()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let layout = duePaymentsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
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
                self.duePaymentsCollectionView.reloadData()
            }
        }
    }

}

extension DuePaymentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DuePaymentsFormCollectionViewCell.reuseIdentifier, for: indexPath) as? DuePaymentsFormCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.delegate = self
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

extension DuePaymentsViewController: DuePaymentsFormCollectionViewCellDelegate {
    
    func didTapSubmitButton(in cell: DuePaymentsFormCollectionViewCell) {
        // Show a confirmation alert before submitting
        let alertController = UIAlertController(
            title: "Confirm Submission",
            message: "Are you sure you want to submit?",
            preferredStyle: .alert
        )
        
        let submitAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            cell.submitButton.isEnabled = false
            cell.submitButton.setTitle("Submitting form...", for: .normal)
            if let reminder = self?.reminderDetail {
                PaymentService().submitPaymentReminder(id: reminder.id) { [weak self] success in
                    DispatchQueue.main.async {
                        if (success != nil) {
                            self?.navigationController?.popViewController(animated: true)
                        } else {
                            self?.navigationController?.popViewController(animated: true)
                            self?.showAlert(message: "Submission failed. Please try again later.")
                        }
                    }
                }
            } else {
                self?.showAlert(message: "Submission failed. Please try again later.")
            }
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "UHive", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
