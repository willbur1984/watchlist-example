//
//  Watchlist.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Foundation

struct Watchlist: Comparable, Decodable, Identifiable {
    // MARK: - Private Types
    private enum CodingKeys: String, CodingKey {
        case id = "cms-id"
        case name
        case order = "order-index"
    }
    
    // MARK: - Public Properties
    let id: String
    let name: String
    let order: Int
    
    // MARK: - Comparable
    static func < (lhs: Watchlist, rhs: Watchlist) -> Bool {
        lhs.order < rhs.order
    }
}
