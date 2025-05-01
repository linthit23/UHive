//
//  FacilityBookingViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class FacilityBookingViewController: UIViewController {

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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FacilityBookingFormCollectionViewCell.reuseIdentifier, for: indexPath) as? FacilityBookingFormCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}

