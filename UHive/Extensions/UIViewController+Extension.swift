//
//  UIViewController+Extension.swift
//  UHive
//
//  Created by Lin Thit on 5/3/25.
//

import UIKit

extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let maxWidthPercentage: CGFloat = 0.8
        let horizontalPadding: CGFloat = 32
        let verticalPadding: CGFloat = 16
        
        let maxLabelWidth = self.view.frame.size.width * maxWidthPercentage - horizontalPadding
        let expectedSize = toastLabel.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        let labelWidth = expectedSize.width + horizontalPadding
        let labelHeight = expectedSize.height + verticalPadding
        
        toastLabel.frame = CGRect(
            x: (self.view.frame.size.width - labelWidth) / 2,
            y: self.view.frame.size.height - 120,
            width: labelWidth,
            height: labelHeight
        )
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
    
    func showSuccessToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.9)
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let maxWidthPercentage: CGFloat = 0.8
        let horizontalPadding: CGFloat = 32
        let verticalPadding: CGFloat = 16
        
        let maxLabelWidth = self.view.frame.size.width * maxWidthPercentage - horizontalPadding
        let expectedSize = toastLabel.sizeThatFits(CGSize(width: maxLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        let labelWidth = expectedSize.width + horizontalPadding
        let labelHeight = expectedSize.height + verticalPadding
        
        toastLabel.frame = CGRect(
            x: (self.view.frame.size.width - labelWidth) / 2,
            y: self.view.frame.size.height - 120,
            width: labelWidth,
            height: labelHeight
        )
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }


}

