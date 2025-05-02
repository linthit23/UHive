//
//  ProfileViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/23/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        setupCloseGesture()
        fetchProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        avatarImageView.roundCorners(
            radius: 36,
            corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
        )
    }
    
    func style() {
        logoutButton.addDropShadow()
        logoutButton.tintColor = .white
    }
    
    func layout() {
        // Add any layout customization here
    }
    
    func setupCloseGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalVC))
        closeImageView.isUserInteractionEnabled = true
        closeImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissModalVC() {
        self.dismiss(animated: true)
    }
    
    func fetchProfile() {
        ProfileService().fetchProfile { [weak self] profile in
            guard let self = self, let profile = profile else {
                print("Failed to load profile")
                return
            }
            
            DispatchQueue.main.async {
                self.nameLabel.text = profile.name
                self.userNameLabel.text = "@\(profile.name.lowercased().replacingOccurrences(of: " ", with: ""))"
                self.emailLabel.text = profile.email
            }
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        // Show a confirmation alert before logging out
        let alertController = UIAlertController(
            title: "Confirm Logout",
            message: "Are you sure you want to log out?",
            preferredStyle: .alert
        )
        
        let logoutAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            // Log out the user using AuthManager
            AuthManager.shared.logout()
            
            // Redirect to the login screen
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let loginVC = LoginViewController()  // Create login screen view controller
                let navController = UINavigationController(rootViewController: loginVC)
                sceneDelegate.window?.rootViewController = navController
            }
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
}
