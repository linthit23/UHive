//
//  BookedFacilityViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class BookedFacilityViewController: UIViewController {

    var booking: FacilityBooking!
    
    @IBOutlet weak var bookedFacilityCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookedFacilityCollectionView.delegate = self
        bookedFacilityCollectionView.dataSource = self
        bookedFacilityCollectionView.register(UINib(nibName: BookedFacilityFormCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: BookedFacilityFormCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let layout = bookedFacilityCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}

}

extension BookedFacilityViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = booking {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookedFacilityFormCollectionViewCell.reuseIdentifier, for: indexPath) as? BookedFacilityFormCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        if let booking = booking {
            cell.configure(with: booking)
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

extension BookedFacilityViewController: BookedFacilityFormCollectionViewCellDelegate {
    func didTapCancelButton(in cell: BookedFacilityFormCollectionViewCell) {
        let alertController = UIAlertController(
            title: "Cancel Booking",
            message: "Are you sure you want to cancel?",
            preferredStyle: .alert
        )
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) {
            [weak self] _ in
            cell.facilityBookingCancelButton.isEnabled = false
            cell.facilityBookingCancelButton.setTitle("Canceling booking...", for: .normal)
            
            guard let booking = self?.booking else {
                self?.showAlert(message: "Cancel booking failed. Please try again later.")
                return
            }
                
                BookingsService().cancelBooking(id: booking.id) { [weak self] success in
                    DispatchQueue.main.async {
                        if (success != nil) {
                            self?.navigationController?.popViewController(animated: true)
                        } else {
                            self?.navigationController?.popViewController(animated: true)
                            self?.showAlert(message: "Cancel booking failed. Please try again later.")
                        }
                    }
                }
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .destructive)
        
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "UHive", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
