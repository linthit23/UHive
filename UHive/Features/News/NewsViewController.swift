//
//  NewsViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(UINib(nibName: NewsCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: NewsCollectionViewCell.reuseIdentifier)
        
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

        if let layout = newsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}
    
    @objc func dismissModalVC() {
        self.dismiss(animated: true)
    }
    
    func openNews(_ indexPath: IndexPath) {
        let newsDetailVC = NewsDetailViewController()
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(newsDetailVC, animated: true)
    }

}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == newsCollectionView {
            openNews(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newsCollectionView {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == newsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.reuseIdentifier, for: indexPath) as? NewsCollectionViewCell else {
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
        if collectionView == newsCollectionView {
            let padding: CGFloat = 10
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 1
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 100)
        }
        return CGSize.zero
    }
}
