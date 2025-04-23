//
//  UIButton+Extension.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

extension UIButton {
    
    func addDropShadow(
        color: UIColor = .black,
        opacity: Float = 0.25,
        offset: CGSize = CGSize(width: 0, height: 0),
        blur: CGFloat = 5,
        spread: CGFloat = 0
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = blur / 2.0
        layer.masksToBounds = false
        
        let rect: CGRect
        if spread == 0 {
            rect = bounds
        } else {
            let dx = -spread
            rect = bounds.insetBy(dx: dx, dy: dx)
        }
        
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius).cgPath
    }
}
