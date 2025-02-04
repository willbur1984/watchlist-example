//
//  Publisher+Extensions.swift
//  watchlist-example
//
//  Created by William Towe on 2/4/25.
//

import Combine
import Foundation

extension Publisher where Failure == Never {
    // MARK: - Public Functions
    func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on object: Root) -> AnyCancellable {
        sink { [weak object] in
            object?[keyPath: keyPath] = $0
        }
    }
}
