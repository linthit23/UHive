//
//  SceneDelegate.swift
//  UHive
//
//  Created by Lin Thit on 4/20/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let isLoggedIn = AuthManager.shared.token != nil  // ✅ Token-based check
        
        let rootVC: UIViewController
        if isLoggedIn {
            rootVC = MainViewController()
        } else {
            rootVC = LoginViewController()
        }
        
        window.rootViewController = UINavigationController(rootViewController: rootVC)
        self.window = window
        window.makeKeyAndVisible()
    }


}

