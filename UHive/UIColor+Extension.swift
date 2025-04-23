//
//  UIColor+Extension.swift
//  UHive
//
//  Created by Lin Thit on 4/22/25.
//

import UIKit

extension UIColor {
    static let primaryColor: UIColor = UIColor(hex: "2FABCD", alpha: 1)
    static let secondaryColor: UIColor = UIColor(hex: "99E9FF", alpha: 1)
    static let backgroundColor: UIColor = UIColor(hex: "EDFBFF", alpha: 1)
}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
