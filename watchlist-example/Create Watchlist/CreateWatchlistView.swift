//
//  CreateWatchlistView.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Foundation
import SwiftUI

struct CreateWatchlistView: View {
    // MARK: - Public Properties
    @StateObject
    var viewModel: CreateWatchlistViewModel
    
    // MARK: - View
    var body: some View {
        TextField(String(localized: "watchlist.create.name.placeholder", defaultValue: "Enter watchlist name"), text: $viewModel.watchlist.name)
            .padding(.padding)
            .overlay(RoundedRectangle(cornerRadius: .cornerRadius)
                .stroke(.gray)
            )
            .padding()
        List {
            ForEach(viewModel.watchlist.entries) {
                Text($0.symbol)
            }
        }
        .overlay {
            if viewModel.watchlist.entries.isEmpty {
                ContentUnavailableView(String(localized: "watchlist.create.empty.title", defaultValue: "No Entries"), systemImage: "dollarsign", description: Text(String(localized: "watchlist.create.empty.description", defaultValue: "Tap the plus icon to add an entry.")))
            }
        }
    }
}
