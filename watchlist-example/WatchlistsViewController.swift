//
//  WatchlistsViewController.swift
//  watchlist-example
//
//  Created by William Towe on 2/3/25.
//

import Foundation
import UIKit

final class WatchlistsViewController: BaseHostingController<WatchlistsView> {
    // MARK: - Private Properties
    private let viewModel = WatchlistsViewModel()
    
    // MARK: - Override Functions
    override func setup() {
        super.setup()
        
        self.title = "Watchlists"
        self.navigationItem.rightBarButtonItem = .init(systemItem: .add, primaryAction: .init(handler: { _ in
            
        }))
    }
    
    // MARK: - Initializers
    init() {
        super.init(rootView: WatchlistsView(viewModel: self.viewModel))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is unavailable")
    }
}
