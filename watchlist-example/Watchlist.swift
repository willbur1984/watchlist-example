//
//  Watchlist.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Foundation

struct Watchlist: Comparable, Decodable, Identifiable {
    // MARK: - Public Types
    struct WatchlistEntry: Decodable, Equatable, Identifiable {
        // MARK: - Public Properties
        var symbol: String
        
        // MARK: - Identifiable
        var id: String {
            self.symbol
        }
    }
    
    // MARK: - Private Types
    private enum CodingKeys: String, CodingKey {
        case id = "cms-id"
        case name
        case order = "order-index"
        case entries = "watchlist-entries"
    }
    
    // MARK: - Public Properties
    var id: String?
    var name: String
    var order: Int
    var entries: [WatchlistEntry]
    
    // MARK: - Comparable
    static func < (lhs: Watchlist, rhs: Watchlist) -> Bool {
        lhs.order < rhs.order
    }
}

extension Watchlist.WatchlistEntry {
    // MARK: - Initializers
    init(searchItem: SearchResponse.SearchData.SearchItem) {
        self.symbol = searchItem.symbol
    }
}
