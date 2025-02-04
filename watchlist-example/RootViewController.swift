//
//  RootViewController.swift
//  watchlist-example
//
//  Created by William Towe on 2/3/25.
//

import Feige
import UIKit

final class RootViewController: UINavigationController {
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [
            WatchlistViewController()
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.present(LoginViewController.forPresenting(), animated: true)
    }
}

