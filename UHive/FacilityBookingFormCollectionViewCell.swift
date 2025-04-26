//
//  FacilityBookingFormCollectionViewCell.swift
//  UHive
//
//  Created by Lin Thit on 4/25/25.
//

import UIKit

class FacilityBookingFormCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    static let reuseIdentifier: String = String(describing: FacilityBookingFormCollectionViewCell.self)

    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var facilityPictureImageView: UIImageView!
    @IBOutlet weak var facilityNameLabel: UILabel!
    @IBOutlet weak var facilityBookingDateDatePicker: UIDatePicker!
    @IBOutlet weak var facilityNumberOfPeople: UIPickerView!
    @IBOutlet weak var facilityTimeSlotCollectionView: UICollectionView!
    @IBOutlet weak var facilityReasonForUseTextField: UITextField!
    @IBOutlet weak var facilityBookingBookButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        facilityTimeSlotCollectionView.delegate = self
        facilityTimeSlotCollectionView.dataSource = self
        facilityTimeSlotCollectionView.register(UINib(nibName: FacilityTimeSlotCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FacilityTimeSlotCollectionViewCell.reuseIdentifier)
        
        style()
        
        facilityReasonForUseTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func  style() {
        facilityBookingBookButton.addDropShadow()
        facilityBookingBookButton.tintColor = .white
    }
    
    @objc func dismissKeyboard() {
        contentView.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let activeTextField = findActiveTextField() {
            if let userInfo = notification.userInfo {
                let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                let keyboardHeight = keyboardFrame.height
                
                let textFieldRect = activeTextField.convert(activeTextField.bounds, to: contentView)
                
                let offset = textFieldRect.maxY - (contentView.frame.height - keyboardHeight - 20)
                
                if offset > 0 {
                    UIView.animate(withDuration: 0.3) {
                        self.contentView.frame.origin.y = -offset
                    }
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.contentView.frame.origin.y = 0
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

}

extension FacilityBookingFormCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FacilityTimeSlotCollectionViewCell.reuseIdentifier, for: indexPath) as? FacilityTimeSlotCollectionViewCell else {
            return UICollectionViewCell()
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
            return CGSize(width: 100, height: 35)
    }
}
