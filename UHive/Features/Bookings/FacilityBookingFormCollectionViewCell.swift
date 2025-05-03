//
//  FacilityBookingFormCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class FacilityBookingFormCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    weak var delegate: FacilityBookingFormCollectionViewCellDelegate?
    
    static let reuseIdentifier: String = String(describing: FacilityBookingFormCollectionViewCell.self)

    var facility: Facility!
    private let numberOfPeopleOptions = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

    var date: String!
    var numberOfPeople: Int = 1
    var start: String!
    var end: String!
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var facilityPictureImageView: UIImageView!
    @IBOutlet weak var facilityNameLabel: UILabel!
    @IBOutlet weak var facilityBookingDateDatePicker: UIDatePicker!
    @IBOutlet weak var facilityNumberOfPeople: UIPickerView!
    @IBOutlet weak var facilityTimeSlotCollectionView: UICollectionView!
    @IBOutlet weak var facilityReasonForUseTextField: UITextField!
    @IBOutlet weak var facilityBookingBookButton: UIButton!
    
    var originalPosition: CGPoint = .zero
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        facilityTimeSlotCollectionView.delegate = self
        facilityTimeSlotCollectionView.dataSource = self
        facilityTimeSlotCollectionView.register(UINib(nibName: FacilityTimeSlotCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FacilityTimeSlotCollectionViewCell.reuseIdentifier)
        
        style()
        
        facilityReasonForUseTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        facilityNumberOfPeople.delegate = self
        facilityNumberOfPeople.dataSource = self
    }
    
    func  style() {
        facilityBookingBookButton.addDropShadow()
        facilityBookingBookButton.tintColor = .white
    }
    
    func configure(with facility: Facility) {
        facilityNameLabel.text = facility.name
        // Set to one day ahead of now
        if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
            facilityBookingDateDatePicker.date = tomorrow
            let datePickerDate = facilityBookingDateDatePicker.date
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            date = formatter.string(from: datePickerDate)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let activeTextField = findActiveTextField() {
            if originalPosition == .zero {
                originalPosition = activeTextField.frame.origin
            }
            if let userInfo = notification.userInfo {
                let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                let keyboardHeight = keyboardFrame.height
                
                let textFieldRect = activeTextField.convert(activeTextField.bounds, to: contentView)
                let offset = textFieldRect.maxY - (contentView.frame.height - keyboardHeight - 20)
                
                if offset > 0 {
                    UIView.animate(withDuration: 0.3) {
                        self.facilityPictureImageView.alpha = 0
                        self.contentContainerView.frame.origin.y = -offset
                    }
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.contentContainerView.frame.origin.y = 0
        }
        
        if let activeTextField = findActiveTextField() {
            UIView.animate(withDuration: 0.3) {
                self.facilityPictureImageView.alpha = 1
                activeTextField.frame.origin = self.originalPosition
            }
        }
    }


    
    func findActiveTextField() -> UITextField? {
        if  facilityReasonForUseTextField.isFirstResponder {
            return facilityReasonForUseTextField
        }
        return nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func selectTimeSlot(_ indexPath: IndexPath) {
        start = facility.availableHours[indexPath.row].start
        end = facility.availableHours[indexPath.row].end
    }
    
    @IBAction func bookButtonTaped(_ sender: UIButton) {
        delegate?.didTapBookButton(in: self)
    }

}

extension FacilityBookingFormCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectTimeSlot(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let facility = facility {
            return facility.availableHours.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FacilityTimeSlotCollectionViewCell.reuseIdentifier, for: indexPath) as? FacilityTimeSlotCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let facility = facility {
            cell.configure(with: facility.availableHours[indexPath.row])
        }
        return cell
    }
    
    // MARK: - Layout Configuration
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 70, height: 35)
    }
}

extension FacilityBookingFormCollectionViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfPeopleOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberOfPeopleOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedPeople = numberOfPeopleOptions[row]
        numberOfPeople = Int(selectedPeople) ?? 0
    }

}

protocol FacilityBookingFormCollectionViewCellDelegate: AnyObject {
    func didTapBookButton(in cell: FacilityBookingFormCollectionViewCell)
}
