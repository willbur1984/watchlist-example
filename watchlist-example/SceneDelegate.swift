//
//  SceneDelegate.swift
//  watchlist-example
//
//  Created by William Towe on 2/3/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - UIWindowSceneDelegate
    var window: UIWindow?

    // MARK: - UISceneDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        self.window = UIWindow(windowScene: windowScene)
    }
}

