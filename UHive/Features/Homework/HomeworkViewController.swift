//
//  HomeworkViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

class HomeworkViewController: UIViewController {
    
    private var tests: [Test] = []
    
    @IBOutlet weak var alertCollectionView: UICollectionView!
    @IBOutlet weak var alertViewAllLabel: UILabel!
    @IBOutlet weak var homeworkCollectionView: UICollectionView!
    @IBOutlet weak var homeWorkViewAllLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertCollectionView.delegate = self
        alertCollectionView.dataSource = self
        alertCollectionView.register(UINib(nibName: AlertCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: AlertCollectionViewCell.reuseIdentifier)
        
        homeworkCollectionView.delegate = self
        homeworkCollectionView.dataSource = self
        homeworkCollectionView.register(UINib(nibName: HomeworkCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: HomeworkCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        
        let alertViewAllTapGesture = UITapGestureRecognizer(target: self, action: #selector(openAlert))
        alertViewAllLabel.isUserInteractionEnabled = true
        alertViewAllLabel.addGestureRecognizer(alertViewAllTapGesture)
        
        let homeworkViewAllTapGesture = UITapGestureRecognizer(target: self, action: #selector(openHomework))
        homeWorkViewAllLabel.isUserInteractionEnabled = true
        homeWorkViewAllLabel.addGestureRecognizer(homeworkViewAllTapGesture)
        
        fetchTests()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        alertCollectionView.isScrollEnabled = false
        homeworkCollectionView.isScrollEnabled = false
    }
    
    private func style() {}
    
    @objc func openAlert() {
        let allAlertVC = AllAlertViewController()
        allAlertVC.tests = tests
        allAlertVC.modalPresentationStyle = .pageSheet
        allAlertVC.isModalInPresentation = true
        self.present(allAlertVC, animated: true)
    }
    
    @objc func openHomework() {
        let allHomeworkVC = AllHomeworkViewController()
        allHomeworkVC.modalPresentationStyle = .pageSheet
        allHomeworkVC.isModalInPresentation = true
        self.present(allHomeworkVC, animated: true)
    }
    
    func fetchTests() {
        AlertsService().fetchAllTests { [weak self] testResponse in
            guard let self = self, let tests = testResponse?.data else {
                print("Failed to load tests")
                return
            }
            self.tests = tests
            
            DispatchQueue.main.async {
                self.alertCollectionView.reloadData()
            }
        }
    }

}

extension HomeworkViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == alertCollectionView {
            return tests.count
        } else if collectionView == homeworkCollectionView {
            return 3
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == alertCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlertCollectionViewCell.reuseIdentifier, for: indexPath) as? AlertCollectionViewCell else {
                return UICollectionViewCell()
            }
            let test = tests[indexPath.item]
            cell.configure(with: test)
            return cell
        } else if collectionView == homeworkCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeworkCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeworkCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == alertCollectionView {
            return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        } else if collectionView == homeworkCollectionView {
            return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == alertCollectionView ? 10 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == alertCollectionView ? 10 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == alertCollectionView {
            let padding: CGFloat = 16
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 1
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 110)
        } else if collectionView == homeworkCollectionView {
            let padding: CGFloat = 16
            let spacing: CGFloat = 10
            let itemsPerRow: CGFloat = 1
            
            let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: 70)
        }
        return CGSize.zero
    }
    
}
