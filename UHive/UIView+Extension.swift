//
//  UIView+Extension.swift
//  UHive
//
//  Created by Lin Thit on 4/22/25.
//

import UIKit

extension UIView {
    
    func roundCorners(radius: CGFloat, corners: CACornerMask) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
        self.layer.masksToBounds = true
    }
}
