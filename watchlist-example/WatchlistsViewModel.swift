//
//  WatchlistsViewModel.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class WatchlistsViewModel: BaseViewModel, ObservableObject {
    // MARK: - Public Properties
    @Published
    private(set) var isLoggedIn = false
    @Published
    private(set) var watchlists = [Watchlist]()
    
    // MARK: - Private Properties
    private let networkManager: NetworkManager
    
    // MARK: - Public Functions
    func refresh() async throws -> WatchlistsResponse {
        do {
            let retval = try await self.networkManager.watchlists()
            
            self.watchlists = retval.data.watchlists
            
            return retval
        }
        catch {
            self.watchlists = []
            
            throw error
        }
    }
    
    // MARK: - Initializers
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
        
        super.init()
        
        Task { @MainActor in
            try? await self.refresh()
        }
        
        self.networkManager.isLoggedIn
            .receive(on: DispatchQueue.main)
            .assign(to: \WatchlistsViewModel.isLoggedIn, on: self)
            .store(in: &self.cancellables)
    }
}
