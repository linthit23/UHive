//
//  NewsDetailViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/24/25.
//

import UIKit
import SDWebImage

class NewsDetailViewController: UIViewController {

    var newsId: String!
    var newsDetail: NewsDetailResponse?
    
    @IBOutlet weak var newsDetailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsDetailCollectionView.delegate = self
        newsDetailCollectionView.dataSource = self
        newsDetailCollectionView.register(UINib(nibName: NewsDetailCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: NewsDetailCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        fetchNewsDetail()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        if let layout = newsDetailCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    private func style() {}
    
    func fetchNewsDetail() {
        NewsService().fetchNewsById(id: newsId) { [weak self] newsDetail in
            guard let self = self, let newsDetail = newsDetail else {
                print("Failed to load news detail")
                return
            }
            self.newsDetail = newsDetail
            DispatchQueue.main.async {
                self.newsDetailCollectionView.reloadData()
            }
        }
    }

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
            if let detail = newsDetail {
                cell.announcedFigureImageView.sd_setImage(
                    with: URL(string: "https://images.pexels.com/photos/256559/pexels-photo-256559.jpeg"),
                    placeholderImage: UIImage(systemName: "photo"))
                cell.configure(with: detail)
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
            return CGSize(width: collectionView.frame.width-32, height: 525)
        }
        return .zero
    }
    
    
}
