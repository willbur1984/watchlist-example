//
//  LoginViewModel.swift
//  watchlist-example
//
//  Created by William Towe on 2/4/25.
//

import Combine
import Feige
import Foundation

@MainActor
final class LoginViewModel: BaseViewModel, ObservableObject {
    // MARK: - Public Types
    enum LoginError: Error {
        case emptyUsername
        case emptyPassword
    }
    
    // MARK: - Public Properties
    var isLoggedIn: AnyPublisher<Bool, Never> {
        self.networkManager.isLoggedIn
    }
    
    // MARK: -
    @Published
    var username = ""
    @Published
    var password = ""
    @Published
    private(set) var canLogin = false
    
    // MARK: - Private Properties
    @Published
    private var isLoggingIn = false
    private let networkManager: NetworkManager
    
    // MARK: - Public Functions
    func login() async throws -> LoginResponse {
        guard let username = self.username.nilIfEmpty else {
            throw LoginError.emptyUsername
        }
        guard let password = self.password.nilIfEmpty else {
            throw LoginError.emptyPassword
        }
        defer {
            self.isLoggingIn = false
        }
        self.isLoggingIn = true
        
        return try await self.networkManager.login(username: username, password: password)
    }
    
    // MARK: - Initializers
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
        
        super.init()
        
        Task {
            self.username = await self.networkManager.username() ?? ""
            self.password = await self.networkManager.password() ?? ""
        }
        
        self.$username.removeDuplicates()
            .combineLatest(self.$password.removeDuplicates(), self.$isLoggingIn.removeDuplicates())
            .map { username, password, isLoggingIn in
                username.isNotEmpty && password.isNotEmpty && isLoggingIn.not()
            }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: \LoginViewModel.canLogin, on: self)
            .store(in: &self.cancellables)
    }
}
