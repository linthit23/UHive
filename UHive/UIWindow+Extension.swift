//
//  UIWindow+Extension.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

extension UIWindow {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated else {
            self.rootViewController = vc
            self.makeKeyAndVisible()
            return
        }
        
        self.rootViewController = vc
        self.makeKeyAndVisible()
        
        let transition = CATransition()
        transition.type = .fade
        transition.duration = 0.3
        self.layer.add(transition, forKey: kCATransition)
    }
}
