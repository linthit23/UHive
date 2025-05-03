//
//  FacilityBookingViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class FacilityBookingViewController: UIViewController {

    var facility: Facility!
    
    @IBOutlet weak var facilityBookingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        facilityBookingCollectionView.delegate = self
        facilityBookingCollectionView.dataSource = self
        facilityBookingCollectionView.register(UINib(nibName: FacilityBookingFormCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FacilityBookingFormCollectionViewCell.reuseIdentifier)

        
        layout()
        style()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let layout = facilityBookingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}

}

extension FacilityBookingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = facility {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FacilityBookingFormCollectionViewCell.reuseIdentifier, for: indexPath) as? FacilityBookingFormCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        if let facility = facility {
            cell.facility = facility
            cell.configure(with: facility)
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

extension FacilityBookingViewController: FacilityBookingFormCollectionViewCellDelegate {
    
    func didTapBookButton(in cell: FacilityBookingFormCollectionViewCell) {
        // Safely unwrap all the required values
        guard let date = cell.date, !date.isEmpty,
              let start = cell.start,
              let end = cell.end else {
            self.showToast(message: "You need to select a time slot.")
            return
        }
        
        let alertController = UIAlertController(
            title: "Confirm Booking",
            message: "Are you sure you want to book?",
            preferredStyle: .alert
        )
        
        let bookAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            cell.facilityBookingBookButton.isEnabled = false
            cell.facilityBookingBookButton.setTitle("Booking facility...", for: .normal)
            
            guard let facility = self?.facility else {
                self?.showAlert(message: "Booking failed. Please try again later.")
                return
            }
            
            let reasonText = cell.facilityReasonForUseTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let reason = (reasonText?.isEmpty ?? true) ? "None." : reasonText!
            
            BookingsService().bookFacility(
                id: facility.id,
                date: date,
                start: start,
                end: end,
                numberOfPeople: cell.numberOfPeople,
                reason: reason
            ) { [weak self] success in
                DispatchQueue.main.async {
                    if (success != nil) {
                        self?.navigationController?.popViewController(animated: true)
                    } else {
                        self?.navigationController?.popViewController(animated: true)
                        self?.showAlert(message: "Booking failed. Please try again later.")
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
        
        alertController.addAction(bookAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "UHive", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

