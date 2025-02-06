//
//  WatchlistsView.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Feige
import Foundation
import SwiftUI

struct WatchlistsView: View {
    // MARK: - Public Properties
    @StateObject
    var viewModel: WatchlistsViewModel
    
    // MARK: - View
    var body: some View {
        List {
            ForEach(viewModel.watchlists) {
                Text($0.name)
            }
        }
        .refreshable {
            Task { @MainActor in
                do {
                    _ = try await viewModel.refresh()
                }
                catch {
                    refreshError = error
                    isDisplayingRefreshAlert = true
                }
            }
        }
        .alert(String.alertTitle, isPresented: $isDisplayingRefreshAlert) {
            Button(String.buttonOkay, role: .cancel) {}
        } message: {
            Text(refreshError?.localizedDescription ?? .alertMessage)
        }
        .overlay {
            if viewModel.watchlists.isEmpty {
                ContentUnavailableView(String(localized: "watchlists.empty.title", defaultValue: "No Watchlists"), systemImage: "list.bullet", description: Text(String(localized: "watchlists.empty.description", defaultValue: "Tap the plus icon to create a watchlist.")))
            }
        }
        .overlay {
            if viewModel.isLoggedIn.not() {
                ContentUnavailableView(String(localized: "watchlists.logged-out.title", defaultValue: "Logged Out"), systemImage: "person", description: Text(String(localized: "watchlist.logged-out.description", defaultValue: "Login to view your watchlists.")))
            }
        }
    }
    
    // MARK: - Private Properties
    @State
    private var isDisplayingRefreshAlert = false
    @State
    private var refreshError: Error?
}
