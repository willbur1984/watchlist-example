//
//  AddWatchlistEntryViewController.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Feige
import Foundation
import UIKit

final class AddWatchlistEntryViewController: BaseHostingController<AddWatchlistEntryView>, UISearchResultsUpdating {
    // MARK: - Private Properties
    private let viewModel = AddWatchlistEntryViewModel()
    private let completion: (SearchResponse.SearchData.SearchItem) -> Void
    
    // MARK: - Public Functions
    static func forPresenting(completion: @escaping (SearchResponse.SearchData.SearchItem) -> Void) -> UIViewController {
        UINavigationController(rootViewController: AddWatchlistEntryViewController(completion: completion)).also {
            $0.modalPresentationStyle = .formSheet
        }
    }
    
    // MARK: - Override Functions
    override func setup() {
        super.setup()
        
        self.definesPresentationContext = true
        self.title = "Add Watchlist Entry"
        self.navigationItem.rightBarButtonItem = .dismiss(self)
        self.navigationItem.searchController = UISearchController(searchResultsController: nil).also {
            $0.searchResultsUpdater = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.$selectedItem
            .compactMap {
                $0
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else {
                    return
                }
                self.completion($0)
                self.navigationItem.searchController?.isActive = false
                self.dismiss(animated: true)
            }
            .store(in: &self.cancellables)
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.searchText = searchController.searchBar.text
    }
    
    // MARK: - Initializers
    private init(completion: @escaping (SearchResponse.SearchData.SearchItem) -> Void) {
        self.completion = completion
        
        super.init(rootView: AddWatchlistEntryView(viewModel: self.viewModel))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is unavailable")
    }
}
