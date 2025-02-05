//
//  WatchlistsResponse.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Foundation

struct WatchlistsResponse: Decodable {
    // MARK: - Public Types
    struct WatchlistsData: Decodable {
        // MARK: - Private Types
        private enum CodingKeys: String, CodingKey {
            case watchlists = "items"
        }
        
        // MARK: - Public Properties
        let watchlists: [Watchlist]
    }
    
    // MARK: - Public Properties
    let data: WatchlistsData
}
