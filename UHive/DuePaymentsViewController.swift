//
//  DuePaymentsViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

class DuePaymentsViewController: UIViewController {

    @IBOutlet weak var duePaymentsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        duePaymentsCollectionView.delegate = self
        duePaymentsCollectionView.dataSource = self
        duePaymentsCollectionView.register(UINib(nibName: DuePaymentsFormCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: DuePaymentsFormCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if let layout = duePaymentsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}


}

extension DuePaymentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DuePaymentsFormCollectionViewCell.reuseIdentifier, for: indexPath) as? DuePaymentsFormCollectionViewCell else {
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

