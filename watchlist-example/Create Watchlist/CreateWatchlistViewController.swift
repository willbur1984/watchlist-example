//
//  CreateWatchlistViewController.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Feige
import Foundation
import SwiftUI

final class CreateWatchlistViewController: BaseHostingController<CreateWatchlistView> {
    // MARK: - Private Properties
    private let viewModel = CreateWatchlistViewModel()
    
    // MARK: - Public Functions
    static func forPresenting() -> UIViewController {
        UINavigationController(rootViewController: CreateWatchlistViewController()).also {
            $0.modalPresentationStyle = .formSheet
        }
    }
    
    // MARK: - Override Functions
    override func setup() {
        super.setup()
        
        self.isModalInPresentation = true
        self.title = "Add Watchlist"
        self.navigationItem.leftBarButtonItem = .dismiss(self)
        self.navigationItem.rightBarButtonItems = self.viewModel.rightBarButtonItems(inViewController: self)
    }
    
    // MARK: - Initializers
    private init() {
        super.init(rootView: CreateWatchlistView(viewModel: self.viewModel))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is unavailable")
    }
}
