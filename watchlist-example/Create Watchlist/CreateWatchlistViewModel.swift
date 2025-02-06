//
//  CreateWatchlistViewModel.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Combine
import Feige
import Foundation
import UIKit

@MainActor
final class CreateWatchlistViewModel: BaseViewModel, ObservableObject {
    // MARK: - Public Properties
    @Published
    var watchlist = Watchlist(name: "", order: 0, entries: [])
    
    // MARK: - Private Properties
    @Published
    private var canSave = false
    @Published
    private var isSaving = false
    
    // MARK: - Public Functions
    func rightBarButtonItems(inViewController viewController: UIViewController) -> [UIBarButtonItem] {
        let add = UIBarButtonItem(systemItem: .add, primaryAction: .init(handler: { _ in
            viewController.present(AddWatchlistEntryViewController.forPresenting(completion: {
                self.watchlist.entries.append(.init(searchItem: $0))
            }), animated: true)
        }))
        let save = UIBarButtonItem(systemItem: .save, primaryAction: .init(handler: { _ in
            
        })).also {
            self.$canSave
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .assign(to: \UIBarButtonItem.isEnabled, on: $0)
                .store(in: &self.cancellables)
        }
        return [add, save]
    }
    
    // MARK: - Initializers
    init(networkManager: NetworkManager = .shared) {
        super.init()
        
        self.$watchlist
            .combineLatest(self.$isSaving.removeDuplicates())
            .map { watchlist, isSaving in
                watchlist.name.isNotEmpty && watchlist.entries.isNotEmpty && isSaving.not()
            }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \CreateWatchlistViewModel.canSave, on: self)
            .store(in: &self.cancellables)
    }
}
