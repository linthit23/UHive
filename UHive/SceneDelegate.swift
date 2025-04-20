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
        
        // 1. Create a new window for the windowScene
        let window = UIWindow(windowScene: windowScene)
        
        // 2. Initialize your view controller
        let rootViewController = RootViewController() // Replace with your VC class
        
        // 3. Embed in NavigationController (optional)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        // 4. Set the root view controller
        window.rootViewController = navigationController
        
        // 5. Make the window visible
        self.window = window
        window.makeKeyAndVisible()
    }


}

