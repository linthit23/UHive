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
