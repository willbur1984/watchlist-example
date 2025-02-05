//
//  LoginViewController.swift
//  watchlist-example
//
//  Created by William Towe on 2/3/25.
//

import Foundation
import SwiftUI
import UIKit

final class LoginViewController: BaseHostingController<LoginView> {
    // MARK: - Private Properties
    private let viewModel = LoginViewModel()
    
    // MARK: - Public Functions
    static func forPresenting() -> UIViewController {
        UINavigationController(rootViewController: LoginViewController())
    }
    
    // MARK: - Override Functions
    override func setup() {
        super.setup()
        
        self.title = String(localized: "login.title", defaultValue: "Login")
        self.navigationItem.rightBarButtonItem = .dismiss(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.isLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self, $0 else {
                    return
                }
                self.presentingViewController?.dismiss(animated: true)
            }
            .store(in: &self.cancellables)
    }
    
    // MARK: - Initializers
    private init() {
        super.init(rootView: LoginView(viewModel: self.viewModel))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is unavailable")
    }
}
