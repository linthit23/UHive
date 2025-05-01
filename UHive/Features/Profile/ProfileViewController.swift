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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModalVC))
        closeImageView.isUserInteractionEnabled = true
        closeImageView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        avatarImageView.roundCorners(radius: 36, corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner])
    }
    
    func style() {
        logoutButton.addDropShadow()
        logoutButton.tintColor = .white
    }
    
    func layout() {
        
    }
    
    @objc func dismissModalVC() {
        self.dismiss(animated: true)
    }


}
