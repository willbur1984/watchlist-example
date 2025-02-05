//
//  RootViewModel.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Combine
import Foundation

final class RootViewModel: BaseViewModel {
    // MARK: - Public Properties
    var isLoggedIn: AnyPublisher<Bool, Never> {
        self.networkManager.isLoggedIn
    }
    
    // MARK: - Private Properties
    private let networkManager: NetworkManager
    
    // MARK: - Initializers
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
        
        super.init()
    }
}
