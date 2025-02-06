//
//  AddWatchlistEntryView.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Foundation
import SwiftUI

struct AddWatchlistEntryView: View {
    // MARK: - Public Properties
    @StateObject
    var viewModel: AddWatchlistEntryViewModel
    
    // MARK: - View
    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                VStack(alignment: .leading) {
                    Text(item.symbol)
                    Text(item.summary)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .onTapGesture {
                    viewModel.selectedItem = item
                }
            }
        }
        .overlay {
            if viewModel.items.isEmpty {
                ContentUnavailableView.search(text: viewModel.searchText ?? "")
            }
        }
    }
}
