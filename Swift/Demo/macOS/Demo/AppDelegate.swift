//
//  AppDelegate.swift
//  Demo (macOS)
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindow: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindow = NSApplication.shared.windows[0]
        NSApp.activate(ignoringOtherApps: true)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // Handles Reopening of Main Window
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag { for window in sender.windows { window.makeKeyAndOrderFront(self) }}
        return true
    }


}

