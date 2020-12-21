//
//  WindowController.swift
//  Example
//
//  Created by Justin Bush on 2020-12-21.
//

import Cocoa

class WindowController: NSWindowController, NSToolbarDelegate {
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func toggleMode(_ sender: NSToolbarItem) {
        NotificationCenter.default.post(Notification(name: .didToggleMode))
    }

}
