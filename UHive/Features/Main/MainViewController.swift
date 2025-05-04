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
        refreshAuth()
    }


    private func setupTabs() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let profileVC = ClassesViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Classes", image: UIImage(systemName: "graduationcap"), tag: 1)
        
        let settingsVC = HomeworkViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Alerts", image: UIImage(systemName: "book.closed"), tag: 2)
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        viewControllers = [homeNav, profileNav, settingsNav]
    }
    
    private func style() {
        tabBar.tintColor = .primaryApp
        tabBar.backgroundColor = .white
    }
    
    private func fetchAndCacheProfile() {
        ProfileService().fetchProfile { [weak self] profile in
            guard let _ = self, let profile = profile else {
                print("Failed to load profile")
                return
            }
            profile.saveToCache()
        }
    }
    
    private func refreshAuth() {
        AuthManager.shared.refreshToken()
        fetchAndCacheProfile()
    }
}
