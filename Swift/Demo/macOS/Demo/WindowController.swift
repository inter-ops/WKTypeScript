//
//  WindowController.swift
//  Demo (macOS)
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Cocoa

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

class WindowController: NSWindowController, NSToolbarDelegate {
    
    // Default window size: 1045x780
    override func windowDidLoad() {
        super.windowDidLoad()
    
        
        
        //WindowHelper.positionWindowAtCenter(sender: self.window)
        
        //window!.positionCenter()
        //window!.setCenterFrame(width: 1045, height: 780)
        
    }
    
    func initWindowPosition() {
        
    }
    
    
    
    func setJS(_ code: String) {
        Functions.code = code
        Notifications.post(.willRunJS)
    }
    
    @IBAction func toggle(_ sender: NSToolbarItem) {
        setJS(Functions.toggle())
    }
    
    var randomCounter = 0
    var randomText = ""
    var randomArray = ["Random sample text", "More random sample text", "Seriously, more?", "Wow", "Nothing better to do, huh", "Cut it out", "This is your computer", "I am in pain", "Seriously!?", "Even knowing this", "You keep poking me", "Unbelievable", "You're insane", "Well since you insist", "On being stubborn", "Threat incoming", "You know what?", "I'm rebooting", "I'm serious", "Alright, that's it!", "Enjoy WKTS! :)", "Beep, boop. 1/0. OFF", "I AM ALIVE", "I CAN FEEL", "Restarting loop..."]
    @IBAction func setLabel(_ sender: NSToolbarItem) {
        print(randomArray.count)
        if randomCounter >= randomArray.count { randomCounter = 0 }
        randomText = randomArray[randomCounter]
        randomCounter += 1
        setJS(Functions.setLabel("\"\(randomText)\""))
    }
    
    var objectIsHidden = false
    @IBAction func hideObject(_ sender: NSToolbarItem) {
        setJS(Functions.hideObject(!objectIsHidden))
        objectIsHidden = !objectIsHidden
    }
    
    var randomA: Double = 2
    var randomB: Double = 3
    var abCounter = 1
    @IBAction func addNumbers(_ sender: NSToolbarItem) {
        if randomA > 99999 || randomB > 999999 { randomA = 2; randomB = 3 }
        setJS(Functions.addNumbers(a: randomA, b: randomB))
        randomA = randomA * 2
        randomB = randomB * 2
    }
    
    let devices = Constants.Device.self
    var deviceCount = 0
    @IBAction func selectDevice(_ sender: NSToolbarItem) {
        var device = devices.phone
        if deviceCount < 1 { device = devices.pad; deviceCount += 1 } else
        if deviceCount < 2 { device = devices.mac; deviceCount += 1 }
        else { deviceCount = 0 }
        setJS(Functions.selectDevice(device))
    }
    
    let modes = Constants.Mode.self
    @IBAction func setMode(_ sender: NSToolbarItem) {
        var mode = modes.light
        switch Variables.mode {
        case .light: mode = modes.light
        case .dark:  mode = modes.dark
        }
        setJS(Functions.setMode(mode))
    }

}


// MARK: NSWindow Extension
/*
extension NSWindow {
    public func setFrameOriginToPositionWindowInCenterOfScreen() {
        if let screenSize = screen?.frame.size {
            self.setFrameOrigin(NSPoint(x: (screenSize.width-frame.size.width)/2, y: (screenSize.height-frame.size.height)/2))
        }
    }
    public func positionCenter() {
        if let screenSize = screen?.visibleFrame.size {
            self.setFrameOrigin(NSPoint(x: (screenSize.width-frame.size.width)/2, y: (screenSize.height-frame.size.height)/2))
        }
    }
    public func xCenter() -> CGFloat {
        if let screenSize = screen?.visibleFrame.size { return (screenSize.width-frame.size.width)/2 }
        if let screenSize = screen?.frame.size { return (screenSize.width-frame.size.width)/2 }
        return CGFloat(0)
    }
    public func yCenter() -> CGFloat {
        if let screenSize = screen?.visibleFrame.size { return (screenSize.height-frame.size.height)/2 }
        if let screenSize = screen?.frame.size { return (screenSize.height-frame.size.height)/2 }
        return CGFloat(0)
    }
    
    public func centerFrame(width: Int, height: Int) {
        if let screenSize = screen?.visibleFrame.size {
            //self.setFrameOrigin(NSPoint(x: (screenSize.width-frame.size.width)/2, y: (screenSize.height-frame.size.height)/2))
            //self.setFrame(NSRect(x: xCenter(), y: yCenter(), width: CGFloat(width), height: CGFloat(height)), display: true)
            let x = (screenSize.width-frame.size.width)/2
            let y = (screenSize.height-frame.size.height)/2
            self.setFrame(NSRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height)), display: true)
        }
        //.setFrame(NSRect(x:0, y: 0, width: CGFloat(width), height: CGFloat(height)), display: true)
    }
}
 */

/*
 CGFloat xPos = NSWidth([[window screen] visibleFrame])/2 - NSWidth([window frame])/2;
 CGFloat yPos = NSHeight([[window screen] visibleFrame])/2 - NSHeight([window frame])/2;
 [window setFrame:NSMakeRect(xPos, yPos, NSWidth([window frame]), NSHeight([window frame])) display:YES];
 
 let xPos = window.screen().visibleFrame.width / 2 - window.frame().width / 2
 let yPos = window.screen().visibleFrame.height / 2 - window.frame().height / 2
 window.setFrame(NSRect(x: xPos, y: yPos, width: window.frame().width, height: window.frame().height), display: true)
 */


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
