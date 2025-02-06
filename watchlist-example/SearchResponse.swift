//
//  SearchResponse.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Foundation

struct SearchResponse: Decodable {
    // MARK: - Public Types
    struct SearchData: Decodable {
        // MARK: - Public Types
        struct SearchItem: Comparable, Decodable, Identifiable {
            // MARK: - Private Types
            private enum CodingKeys: String, CodingKey {
                case symbol
                case type = "instrument-type"
                case order = "autocomplete"
                case summary = "description"
            }
            
            // MARK: - Public Properties
            let symbol: String
            let type: String
            let order: Int?
            let summary: String
            
            // MARK: - Identifiable
            var id: String {
                self.symbol
            }
            
            // MARK: - Comparable
            static func < (lhs: SearchResponse.SearchData.SearchItem, rhs: SearchResponse.SearchData.SearchItem) -> Bool {
                (lhs.order ?? .max) < (rhs.order ?? .max)
            }
        }
        
        // MARK: - Public Properties
        let items: [SearchItem]
    }
    
    // MARK: - Public Properties
    let data: SearchData
}
