//
//  Notifications.swift
//  Example
//
//  Created by Justin Bush on 2021-02-09.
//

import Foundation

// MARK: Notification Extensions
extension Notification.Name {
    static let willRunJS = Notification.Name("willRunJS")
    static let didToggleMode = Notification.Name("didToggleMode")
}

extension ViewController {
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.runJS(_:)), name: .willRunJS, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didToggleMode(_:)), name: .didToggleMode, object: nil)
    }
    
}
