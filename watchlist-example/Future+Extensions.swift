//
//  Future+Extensions.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Combine
import Foundation

extension Future where Failure == Error {
    // MARK: - Initializers
    convenience init(operation: @escaping () async throws -> Output) {
        self.init { completion in
            Task {
                do {
                    completion(.success(try await operation()))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
