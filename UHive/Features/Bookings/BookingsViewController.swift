//
//  BookingsViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class BookingsViewController: UIViewController {
    
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var bookingsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bookingsCollectionView: UICollectionView!
    
    private var facilities: [Facility] = []
    private var facilityBookings: [FacilityBooking] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookingsCollectionView.delegate = self
        bookingsCollectionView.dataSource = self
        bookingsCollectionView.register(UINib(nibName: FacilityCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FacilityCollectionViewCell.reuseIdentifier)
        bookingsCollectionView.register(UINib(nibName: MyBookingsCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MyBookingsCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalVC))
        closeImageView.isUserInteractionEnabled = true
        closeImageView.addGestureRecognizer(tapGesture)
        
        bookingsSegmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        fetchFacilities()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let layout = bookingsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}
    
    @objc func dismissModalVC() {
        self.dismiss(animated: true)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0: fetchFacilities()
        case 1: fetchFacilityBookings()
        default: break
        }
    }
    
    func openFacility(_ indexPath: IndexPath) {
        let facilityBookingVC = FacilityBookingViewController()
        facilityBookingVC.facility = facilities[indexPath.row]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(facilityBookingVC, animated: true)
    }
    
    func openMyBookings(_ indexPath: IndexPath) {
        let bookedFacilityVC = BookedFacilityViewController()
        bookedFacilityVC.booking = self.facilityBookings[indexPath.row]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(bookedFacilityVC, animated: true)
    }
    
    func fetchFacilities() {
        BookingsService().fetchAllFacilities { [weak self] facilitiesResponse in
            guard let self = self, let facilities = facilitiesResponse?.data else {
                print("Failed to load facilities")
                return
            }
            
            self.facilities = facilities
            
            DispatchQueue.main.async {
                self.bookingsCollectionView.reloadData()
            }
        }
    }
    
    func fetchFacilityBookings() {
        BookingsService().fetchAllBookings { [weak self] facilityBookingsResponse in
            guard let self = self, let bookings = facilityBookingsResponse?.data else {
                print("Failed to load bookings")
                return
            }
            
            self.facilityBookings = bookings
            
            DispatchQueue.main.async {
                self.bookingsCollectionView.reloadData()
            }
        }
    }

}

extension BookingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bookingsCollectionView {
            switch bookingsSegmentedControl.selectedSegmentIndex {
            case 0:
                openFacility(indexPath)
            case 1:
                openMyBookings(indexPath)
            default: break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bookingsCollectionView {
            switch bookingsSegmentedControl.selectedSegmentIndex {
            case 0:
                return self.facilities.count
            case 1:
                return self.facilityBookings.count
            default: return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bookingsCollectionView {
            switch bookingsSegmentedControl.selectedSegmentIndex {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FacilityCollectionViewCell.reuseIdentifier, for: indexPath) as? FacilityCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let facility = facilities[indexPath.item]
                cell.configure(with: facility)
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBookingsCollectionViewCell.reuseIdentifier, for: indexPath) as? MyBookingsCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let booking = facilityBookings[indexPath.item]
                cell.configure(with: booking)
                return cell
            default: return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch bookingsSegmentedControl.selectedSegmentIndex {
        case 0:
            return UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        case 1:
            return UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        default: return UIEdgeInsets()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch bookingsSegmentedControl.selectedSegmentIndex {
        case 0:
            return 10
        case 1:
            return 10
        default: return CGFloat()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch bookingsSegmentedControl.selectedSegmentIndex {
        case 0:
            return 10
        case 1:
            return 10
        default: return CGFloat()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch bookingsSegmentedControl.selectedSegmentIndex {
        case 0:
            let padding: CGFloat = 16
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 2
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 140)
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
