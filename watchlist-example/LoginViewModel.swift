//
//  LoginViewModel.swift
//  watchlist-example
//
//  Created by William Towe on 2/4/25.
//

import Combine
import Feige
import Foundation

final class LoginViewModel: BaseViewModel, ObservableObject {
    // MARK: - Public Properties
    @Published
    var username = ""
    @Published
    var password = ""
    @Published
    private(set) var canLogin = false
    
    // MARK: - Private Properties
    @Published
    private var isLoggingIn = false
    
    // MARK: - Public Functions
    func login() {
        
    }
    
    // MARK: - Initializers
    override init() {
        super.init()
        
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
