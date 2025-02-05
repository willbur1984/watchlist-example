//
//  RootViewController.swift
//  watchlist-example
//
//  Created by William Towe on 2/3/25.
//

import Combine
import Feige
import UIKit

final class RootViewController: UINavigationController {
    // MARK: - Private Properties
    private let viewModel = RootViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var hasSubscribedInViewDidAppear = false
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [
            WatchlistViewController()
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard self.hasSubscribedInViewDidAppear.not() else {
            return
        }
        self.hasSubscribedInViewDidAppear = true
        self.viewModel.isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self, $0.not() else {
                    return
                }
                self.present(LoginViewController.forPresenting(), animated: true)
            }
            .store(in: &self.cancellables)
    }
}

