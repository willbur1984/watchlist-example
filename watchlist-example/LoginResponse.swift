//
//  LoginResponse.swift
//  watchlist-example
//
//  Created by William Towe on 2/4/25.
//

import Foundation

struct LoginResponse: Decodable {
    // MARK: - Public Types
    struct LoginData: Decodable {
        // MARK: - Private Types
        private enum CodingKeys: String, CodingKey {
            case sessionToken = "session-token"
        }
        
        // MARK: - Public Properties
        let sessionToken: String
    }
    
    // MARK: - Public Properties
    let data: LoginData
}
