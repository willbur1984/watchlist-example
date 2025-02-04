//
//  UIBarButtonItem+Extensions.swift
//  watchlist-example
//
//  Created by William Towe on 2/4/25.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    // MARK: - Public Functions
    static func dismiss(_ viewController: UIViewController) -> UIBarButtonItem {
        UIBarButtonItem(systemItem: .close, primaryAction: .init(handler: { [weak viewController] _ in
            viewController?.dismiss(animated: true)
        }))
    }
}
