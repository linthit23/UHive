//
//  LoginViewController.swift
//  UHive
//
//  Created by Lin Thit on 4/22/25.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var containerForLoginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var originalTextFieldY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()

        emailTextField.delegate = self
        passwordTextField.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerForLoginView.roundCorners(radius: 32, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    func style() {
        loginButton.addDropShadow()
        loginButton.tintColor = .white
    }
    
    func layout() {
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let activeTextField = findActiveTextField() {
            if let userInfo = notification.userInfo {
                let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                let keyboardHeight = keyboardFrame.height

                let textFieldRect = activeTextField.convert(activeTextField.bounds, to: view)
                
                let offset = textFieldRect.maxY - (view.frame.height - keyboardHeight - 10)
                
                if offset > 0 {
                    UIView.animate(withDuration: 0.3) {
                        self.view.frame.origin.y = -offset
                    }
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }

    func findActiveTextField() -> UITextField? {
        if emailTextField.isFirstResponder {
            return emailTextField
        } else if passwordTextField.isFirstResponder {
            return passwordTextField
        }
        return nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Example: On login button tap
    @IBAction func loginTapped(_ sender: UIButton) {
        // Validate login here...
        
        // Save login status
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        // Create Home and set as root
        let homeVC = MainViewController()
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let navController = UINavigationController(rootViewController: homeVC)
            sceneDelegate.window?.setRootViewController(navController)
        }
    }
}
