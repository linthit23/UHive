//
//  MainViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setupTabs()
    }


    private func setupTabs() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let profileVC = ClassesViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Classes", image: UIImage(systemName: "graduationcap"), tag: 1)
        
        let settingsVC = HomeworkViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Homework", image: UIImage(systemName: "book.closed"), tag: 2)
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        viewControllers = [homeNav, profileNav, settingsNav]
    }
    
    private func style() {
        tabBar.tintColor = .primary
        tabBar.backgroundColor = .white
    }

}
