//
//  String+Extensions.swift
//  watchlist-example
//
//  Created by William Towe on 2/5/25.
//

import Foundation

extension String {
    // MARK: - Public Properties
    static let alertTitle = String(localized: "alert.title", defaultValue: "Error")
    static let alertMessage = String(localized: "alert.message", defaultValue: "Something went wrong. Please try again later.")
    
    static let buttonOkay = String(localized: "button.okay", defaultValue: "Okay")
}
