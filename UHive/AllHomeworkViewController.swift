//
//  AllHomeworkViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/26/25.
//

import UIKit

class AllHomeworkViewController: UIViewController {
    
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var homeworkCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeworkCollectionView.delegate = self
        homeworkCollectionView.dataSource = self
        homeworkCollectionView.register(UINib(nibName: HomeworkCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: HomeworkCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalVC))
        closeImageView.isUserInteractionEnabled = true
        closeImageView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let layout = homeworkCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}
    
    @objc func dismissModalVC() {
        self.dismiss(animated: true)
    }
    
}

extension AllHomeworkViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeworkCollectionView {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeworkCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeworkCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeworkCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == homeworkCollectionView {
            let padding: CGFloat = 10
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 1
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 70)
        }
        return CGSize.zero
    }
}

