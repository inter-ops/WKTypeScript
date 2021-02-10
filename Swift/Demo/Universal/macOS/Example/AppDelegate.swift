//
//  AppDelegate.swift
//  Example
//
//  Created by Justin Bush on 2020-12-19.
//

import Cocoa

/// Enables debug functions and console logs when `true`
let debug = true

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindow: NSWindow!
    @IBOutlet var debugMenu: NSMenuItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindow = NSApplication.shared.windows[0]
        NSApp.activate(ignoringOtherApps: true)
        debugMenu.isHidden = !debug
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // Handles Reopening of Main Window
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            for window in sender.windows {
                window.makeKeyAndOrderFront(self)
            }
        }
        return true
    }


}

