//
//  WindowController.swift
//  Demo (macOS)
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Cocoa



class WindowController: NSWindowController, NSToolbarDelegate {
    
    // Default window size: 1045x780
    override func windowDidLoad() {
        super.windowDidLoad()
        //WindowHelper.positionWindowAtCenter(sender: self.window)
        //window!.positionCenter()
        //window!.setCenterFrame(width: 1045, height: 780)
        
    }
    
    // Set via bulky script reference
    // ie. setJS(Functions.toggle()), setJS(TSIndex.Functions.toggle()
    func setJS(_ code: String) {
        Functions.code = code
        Notifications.post(.willRunJS)
    }
    
    // Or via enum references
    // ie. ts(index: .toggle), ts(mode: .set(.dark))
    func ts(global: TSGlobal.Functions.Name) {
        Functions.code = global.js
        Notifications.post(.willRunJS)
    }
    func ts(index: TSIndex.Functions.Name) {
        Functions.code = index.js
        Notifications.post(.willRunJS)
    }
    func ts(mode: TSMode.Functions.Name) {
        Functions.code = mode.js
        Notifications.post(.willRunJS)
    }
    
    @IBAction func toggle(_ sender: NSToolbarItem) {
        //setJS(Functions.toggle())
        ts(index: .toggle)
    }
    
    var randomCounter = 0
    var randomText = ""
    var randomArray = ["Random sample text", "More random sample text", "Seriously, more?", "Wow", "Nothing better to do, huh", "Cut it out", "This is your computer", "I am in pain", "Seriously!?", "Even knowing this", "You keep poking me", "Unbelievable", "You're insane", "Well since you insist", "On being stubborn", "Threat incoming", "You know what?", "I'm rebooting", "I'm serious", "Alright, that's it!", "Enjoy WKTS! :)", "Beep, boop. 1/0. OFF", "I AM ALIVE", "I CAN FEEL", "Restarting loop..."]
    @IBAction func setLabel(_ sender: NSToolbarItem) {
        print(randomArray.count)
        if randomCounter >= randomArray.count { randomCounter = 0 }
        randomText = randomArray[randomCounter]
        randomCounter += 1
        
        //setJS(Functions.setLabel("\"\(randomText)\""))
        ts(index: .setLabel(randomText))
    }
    
    var objectIsHidden = false
    @IBAction func hideObject(_ sender: NSToolbarItem) {
        //setJS(Functions.hideObject(!objectIsHidden))
        ts(index: .hideObjects(!objectIsHidden))
        
        objectIsHidden = !objectIsHidden
    }
    
    var randomA: Double = 2
    var randomB: Double = 3
    var abCounter = 1
    @IBAction func addNumbers(_ sender: NSToolbarItem) {
        if randomA > 99999 || randomB > 999999 { randomA = 2; randomB = 3 }
        
        //setJS(Functions.addNumbers(a: randomA, b: randomB))
        ts(index: .addNumbers(randomA, randomB))
        
        randomA = randomA * 2
        randomB = randomB * 2
    }
    
    let devices = TSIndex.Constants.Device.self
    var deviceCount = 0
    @IBAction func selectDevice(_ sender: NSToolbarItem) {
        var device = devices.phone
        if deviceCount < 1 { device = devices.pad; deviceCount += 1 } else
        if deviceCount < 2 { device = devices.mac; deviceCount += 1 }
        else { deviceCount = 0 }
        
        //setJS(Functions.selectDevice(device))
        ts(index: .selectDevice(device))
    }
    
    let modes = TSMode.Constants.Mode.self
    @IBAction func setMode(_ sender: NSToolbarItem) {
        var mode = modes.light
        switch Variables.mode {
        case .light: mode = modes.light
        case .dark:  mode = modes.dark
        }
        
        //setJS(Functions.setMode(mode))
        ts(mode: .setMode(mode))
    }

}



extension ViewController {
    func initWindowSize(width: Int, height: Int) {
        //self.view.window?.setFrame(NSRect(x:0, y: 0, width: 1045, height: 780), display: true)
        //let x = self.view.window?.xCenter() ?? CGFloat(0)
        //let y = self.view.window?.yCenter() ?? CGFloat(0)
        
        //self.view.window?.setFrame(NSRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height)), display: true)
    }
}

struct WindowHelper {
    static func positionWindowAtCenter(sender: NSWindow?) {
        if let window = sender {
            let visibleFrame = window.screen?.visibleFrame
            let x = NSWidth((visibleFrame)!)/2 - NSWidth(window.frame)/2
            let y = NSHeight((visibleFrame)!)/2 - NSHeight(window.frame)/2
            let frame = NSMakeRect(x, y, NSWidth(window.frame), NSHeight(window.frame))
            window.setFrame(frame, display: true)
        }
    }
}

// MARK: NSWindow Extensions

extension NSWindow {
    /// Positions the `NSWindow` at the horizontal-vertical center of the `visibleFrame` (takes Status Bar and Dock sizes into account)
    public func positionCenter() {
        if let screenSize = screen?.visibleFrame.size {
            self.setFrameOrigin(NSPoint(x: (screenSize.width-frame.size.width)/2, y: (screenSize.height-frame.size.height)/2))
        }
    }
    /// Centers the window within the `visibleFrame`, and sizes it with the width-by-height dimensions provided.
    public func setCenterFrame(width: Int, height: Int) {
        if let screenSize = screen?.visibleFrame.size {
            let x = (screenSize.width-frame.size.width)/2
            let y = (screenSize.height-frame.size.height)/2
            self.setFrame(NSRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height)), display: true)
        }
    }
    /// Returns the center x-point of the `screen.visibleFrame` (the frame between the Status Bar and Dock).
    /// Falls back on `screen.frame` when `.visibleFrame` is unavailable (includes Status Bar and Dock).
    public func xCenter() -> CGFloat {
        if let screenSize = screen?.visibleFrame.size { return (screenSize.width-frame.size.width)/2 }
        if let screenSize = screen?.frame.size { return (screenSize.width-frame.size.width)/2 }
        return CGFloat(0)
    }
    /// Returns the center y-point of the `screen.visibleFrame` (the frame between the Status Bar and Dock).
    /// Falls back on `screen.frame` when `.visibleFrame` is unavailable (includes Status Bar and Dock).
    public func yCenter() -> CGFloat {
        if let screenSize = screen?.visibleFrame.size { return (screenSize.height-frame.size.height)/2 }
        if let screenSize = screen?.frame.size { return (screenSize.height-frame.size.height)/2 }
        return CGFloat(0)
    }
}
