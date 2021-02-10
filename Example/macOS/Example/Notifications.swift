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
        // MARK: SwiftUI Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.runJS(_:)), name: .willRunJS, object: nil)
        
        // MARK: NSWindow Notifications
        //NotificationCenter.default.addObserver(self, selector: #selector(self.didToggleMode(_:)), name: .didToggleMode, object: nil)
    }
}

struct Notifications {
    static func post(_ name: Notification.Name) {
        NotificationCenter.default.post(Notification(name: name))
    }
}
