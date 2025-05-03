//
//  ClassesViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

class ClassesViewController: UIViewController {
    
    private var classes: [Class] = []
    private var next10days: [Date] = []
    private var filteredClasses: [Class] = []
        
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
        
        setCurrentMonth()
        generateNext10Days()
        fetchClasses()
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
    
    func fetchClasses() {
        ClassesService().fetchAllClasses { [weak self] classesResponse in
            guard let self = self, let classes = classesResponse?.data else {
                print("Failed to load classes")
                return
            }
            self.classes = classes
            self.filterClassesForCurrentDate()
            let indexPath = IndexPath(item: 0, section: 0)
            self.dayCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            self.collectionView(self.classesCollectionView, didSelectItemAt: indexPath)
        }
    }

    func generateNext10Days() {
        var dates: [Date] = []
        let calendar = Calendar.current
        let today = Date()
        
        for i in 0..<10 {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: today) {
                dates.append(nextDate)
            }
        }
        
        next10days = dates
        
        DispatchQueue.main.async {
            self.dayCollectionView.reloadData()
        }
    }
    
    func setCurrentMonth() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthName = dateFormatter.string(from: date)
        monthLabel.text = monthName
    }

    func filterClassesForCurrentDate() {
        let calendar = Calendar.current
        let today = Date()
        
        // Filter the classes that match today's date
        filteredClasses = classes.filter { classItem in
            // Convert session's start time to a Date object
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            guard let sessionDate = isoFormatter.date(from: classItem.start) else {
                return false
            }
            
            // Compare session date with today's date (without considering time)
            return calendar.isDate(sessionDate, inSameDayAs: today)
        }
        self.classesCollectionView.reloadData()
    }

}

extension ClassesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dayCollectionView {
            let selectedDate = next10days[indexPath.item]
            let calendar = Calendar.current
            let isoFormatter = ISO8601DateFormatter()
            isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            filteredClasses = classes
                .filter { classItem in
                    guard let classDate = isoFormatter.date(from: classItem.start) else {
                        return false
                    }
                    return calendar.isDate(classDate, inSameDayAs: selectedDate)
                }
                .sorted { lhs, rhs in
                    guard
                        let lhsDate = isoFormatter.date(from: lhs.start),
                        let rhsDate = isoFormatter.date(from: rhs.start)
                    else {
                        return false
                    }
                    return lhsDate < rhsDate
                }
            
            classesCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dayCollectionView {
            return next10days.count
        } else if collectionView == classesCollectionView {
            return filteredClasses.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dayCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.reuseIdentifier, for: indexPath) as? DayCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: next10days[indexPath.item])
            return cell
        } else if collectionView == classesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassesCollectionViewCell.reuseIdentifier, for: indexPath) as? ClassesCollectionViewCell else {
                return UICollectionViewCell()
            }
            let session = filteredClasses[indexPath.item]
            cell.configure(with: session)
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == dayCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        } else if collectionView == classesCollectionView {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
            return CGSize(width: collectionView.frame.width-32, height: 150)
        }
        return CGSize.zero
    }
    
}
