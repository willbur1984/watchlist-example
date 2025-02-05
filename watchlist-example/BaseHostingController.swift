//
//  BaseHostingController.swift
//  watchlist-example
//
//  Created by William Towe on 2/4/25.
//

import Combine
import Foundation
import SwiftUI
import UIKit

class BaseHostingController<Content>: UIHostingController<Content> where Content: View {
    // MARK: - Public Properties
    lazy var cancellables = Set<AnyCancellable>()
    
    // MARK: - Public Functions
    func setup() {
        
    }
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
    }
    
    // MARK: - Initializers
    override init(rootView: Content) {
        super.init(rootView: rootView)
        
        self.setup()
    }
    
    override init?(coder aDecoder: NSCoder, rootView: Content) {
        super.init(coder: aDecoder, rootView: rootView)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
}
