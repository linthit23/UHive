//
//  ClassesViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

class ClassesViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var classesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        dayCollectionView.register(UINib(nibName: DayCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: DayCollectionViewCell.reuseIdentifier)
        
        classesCollectionView.delegate = self
        classesCollectionView.dataSource = self
        classesCollectionView.register(UINib(nibName: ClassesCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ClassesCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let layout = dayCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        if let layout = classesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}

}

extension ClassesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dayCollectionView {
            return 10
        } else if collectionView == classesCollectionView {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.reuseIdentifier, for: indexPath) as? DayCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        } else if collectionView == classesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassesCollectionViewCell.reuseIdentifier, for: indexPath) as? ClassesCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == dayCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        } else if collectionView == classesCollectionView {
            return UIEdgeInsets(top: 10, left: 16, bottom: 16, right: 16)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == dayCollectionView ? 5 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == dayCollectionView ? 5 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == dayCollectionView {
            return CGSize(width: 80, height: 80)
        } else if collectionView == classesCollectionView {
            return CGSize(width: collectionView.frame.width, height: 170)
        }
        return CGSize.zero
    }
    
}
