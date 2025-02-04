//
//  SceneDelegate.swift
//  watchlist-example
//
//  Created by William Towe on 2/3/25.
//

import Feige
import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - UIWindowSceneDelegate
    var window: UIWindow?

    // MARK: - UISceneDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        self.window = UIWindow(windowScene: windowScene).also {
            $0.backgroundColor = .tertiarySystemBackground
            $0.rootViewController = RootViewController()
        }
        self.window?.makeKeyAndVisible()
    }
}

