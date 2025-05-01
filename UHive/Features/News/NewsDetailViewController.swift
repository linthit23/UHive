//
//  NewsDetailViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var newsDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsDetailCollectionView.delegate = self
        newsDetailCollectionView.dataSource = self
        newsDetailCollectionView.register(UINib(nibName: NewsDetailCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: NewsDetailCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        if let layout = newsDetailCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}

}

extension NewsDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newsDetailCollectionView {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == newsDetailCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? NewsDetailCollectionViewCell else {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == newsDetailCollectionView {
            return CGSize(width: collectionView.frame.width, height: 400)
        }
        return .zero
    }
    
    
}
