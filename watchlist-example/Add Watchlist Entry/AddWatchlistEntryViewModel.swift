//
//  AddWatchlistEntryViewModel.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Combine
import Foundation

@MainActor
final class AddWatchlistEntryViewModel: BaseViewModel, ObservableObject {
    // MARK: - Public Properties
    @Published
    var searchText: String?
    @Published
    private(set) var items = [SearchResponse.SearchData.SearchItem]()
    @Published
    var selectedItem: SearchResponse.SearchData.SearchItem?
    
    // MARK: - Private Properties
    private let networkManager: NetworkManager
    
    // MARK: - Initializers
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
        
        super.init()
        
        self.$searchText
            .removeDuplicates()
            .debounce(for: .seconds(0.33), scheduler: DispatchQueue.main)
            .map { [networkManager] in
                guard let searchText = $0?.nilIfEmpty else {
                    return Just([SearchResponse.SearchData.SearchItem]())
                        .eraseToAnyPublisher()
                }
                return Future {
                    try await networkManager.search(searchText)
                }
                .map {
                    $0.data.items
                }
                .replaceError(with: [])
                .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .assign(to: \AddWatchlistEntryViewModel.items, on: self)
            .store(in: &self.cancellables)
    }
}
