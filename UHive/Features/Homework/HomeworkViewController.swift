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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertCollectionView.delegate = self
        alertCollectionView.dataSource = self
        alertCollectionView.register(UINib(nibName: AlertCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: AlertCollectionViewCell.reuseIdentifier)
        
        layout()
        style()
        
        let alertViewAllTapGesture = UITapGestureRecognizer(target: self, action: #selector(openAlert))
        alertViewAllLabel.isUserInteractionEnabled = true
        alertViewAllLabel.addGestureRecognizer(alertViewAllTapGesture)
        
        fetchTests()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Reload collectionView after layout to ensure frame is ready for sizing
        alertCollectionView.reloadData()
    }
    
    private func layout() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        alertCollectionView.isScrollEnabled = false // Disable scrolling
    }
    
    private func style() {}
    
    @objc func openAlert() {
        let allAlertVC = AllAlertViewController()
        allAlertVC.tests = tests
        allAlertVC.modalPresentationStyle = .pageSheet
        allAlertVC.isModalInPresentation = true
        self.present(allAlertVC, animated: true)
    }
    
    func fetchTests() {
        AlertsService().fetchAllTests { [weak self] testResponse in
            guard let self = self, let tests = testResponse?.data else {
                print("Failed to load tests")
                return
            }
            self.tests = tests
            self.alertViewAllLabel.isHidden = self.visibleTestCount >= self.tests.count

            DispatchQueue.main.async {
                self.alertCollectionView.reloadData()
            }
        }
    }
    
    /// Calculates how many test cells can fit in the visible height of the collection view
    private var visibleTestCount: Int {
        let collectionViewHeight = alertCollectionView.frame.height
        let cellHeight: CGFloat = 110
        let spacing: CGFloat = 10
        let totalCellHeight = cellHeight + spacing
        let maxCells = Int((collectionViewHeight + spacing) / totalCellHeight)
        return min(tests.count, maxCells)
    }
}

extension HomeworkViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return visibleTestCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlertCollectionViewCell.reuseIdentifier, for: indexPath) as? AlertCollectionViewCell else {
            return UICollectionViewCell()
        }
        let test = tests[indexPath.item]
        cell.configure(with: test)
        return cell
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let spacing: CGFloat = 10
        let itemsPerRow: CGFloat = 1
        let totalSpacing = (2 * padding) + ((itemsPerRow - 1) * spacing)
        let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
        return CGSize(width: itemWidth, height: 100)
    }
}
