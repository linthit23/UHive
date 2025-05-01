//
//  HomeViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var featureCollectionView: UICollectionView!
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featureCollectionView.delegate = self
        featureCollectionView.dataSource = self
        featureCollectionView.register(UINib(nibName: FeatureCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FeatureCollectionViewCell.reuseIdentifier)
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        feedCollectionView.register(UINib(nibName: FeedCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openProfile))
        profileView.isUserInteractionEnabled = true
        profileView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profileView.roundCorners(radius: 30, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if let layout = featureCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        if let layout = feedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        
    }
    
    private func style() {}
    
    @objc func openProfile() {
        let profileVC = ProfileViewController()
        profileVC.modalPresentationStyle = .pageSheet
        profileVC.isModalInPresentation = true
        self.present(profileVC, animated: true)
    }
    
    func openFeature(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let newsVC = NewsViewController()
            newsVC.modalPresentationStyle = .pageSheet
            newsVC.isModalInPresentation = true
            let newsNav = UINavigationController(rootViewController: newsVC)
            newsNav.navigationBar.tintColor = .black
            self.present(newsNav, animated: true)
        case 1:
            let bookingsVC = BookingsViewController()
            bookingsVC.modalPresentationStyle = .pageSheet
            bookingsVC.isModalInPresentation = true
            let bookingsNav = UINavigationController(rootViewController: bookingsVC)
            bookingsNav.navigationBar.tintColor = .black
            self.present(bookingsNav, animated: true)
        case 2:
            let paymentsVC = PaymentsViewController()
            paymentsVC.modalPresentationStyle = .pageSheet
            paymentsVC.isModalInPresentation = true
            let paymentsNav = UINavigationController(rootViewController: paymentsVC)
            paymentsNav.navigationBar.tintColor = .black
            self.present(paymentsNav, animated: true)
        default: break
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == featureCollectionView {
            openFeature(indexPath)
        } else if collectionView == feedCollectionView {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featureCollectionView {
            return 3
        } else if collectionView == feedCollectionView {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featureCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCollectionViewCell.reuseIdentifier, for: indexPath) as? FeatureCollectionViewCell else {
                return UICollectionViewCell()
            }
            switch indexPath.row {
            case 0:
                cell.iconImageView.image = UIImage(systemName: "newspaper")
                cell.titleLabel.text = "News"
            case 1:
                cell.iconImageView.image = UIImage(systemName: "bookmark")
                cell.titleLabel.text = "Bookings"
            case 2:
                cell.iconImageView.image = UIImage(systemName: "creditcard")
                cell.titleLabel.text = "Payments"
            default:
                cell.backgroundColor = .white
            }
            return cell
        } else if collectionView == feedCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier, for: indexPath)
            cell.backgroundColor = .systemRed
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == featureCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == featureCollectionView ? 10 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == featureCollectionView ? 10 : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featureCollectionView {
            let padding: CGFloat = 16
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 3
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 120)
        } else if collectionView == feedCollectionView {
            return CGSize(width: collectionView.frame.width, height: 170)
        }
        return CGSize.zero
    }
    
}
