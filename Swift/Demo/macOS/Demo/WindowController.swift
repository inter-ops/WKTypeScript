//
//  WindowController.swift
//  Demo (macOS)
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func runScript(_ script: TypeScript.Body) {
        Notifications.javaScript = script.js
        Notifications.post(.willRunScript)
    }
    
    @IBAction func toggle(_ sender: NSToolbarItem) {
        runScript(.index(.toggle()))
    }
    
    var randomCounter = 0
    var randomText = ""
    var randomArray = ["Random sample text", "More random sample text", "Seriously, more?", "Wow", "Nothing better to do, huh", "Cut it out", "This is your computer", "I am in pain", "Seriously!?", "Even knowing this", "You keep poking me", "Unbelievable", "You're insane", "Well since you insist", "On being stubborn", "Threat incoming", "You know what?", "I'm rebooting", "I'm serious", "Alright, that's it!", "Enjoy WKTS! :)", "Beep, boop. 1/0. OFF", "I AM ALIVE", "I CAN FEEL", "Restarting loop..."]
    @IBAction func setLabel(_ sender: NSToolbarItem) {
        if randomCounter >= randomArray.count { randomCounter = 0 }
        randomText = randomArray[randomCounter]
        randomCounter += 1
        
        runScript(.index(.setLabel(randomText)))
    }
    
    var objectIsHidden = false
    @IBAction func hideObject(_ sender: NSToolbarItem) {
        runScript(.index(.hideObject(!objectIsHidden)))
        objectIsHidden = !objectIsHidden
    }
    
    var randomA: Double = 2
    var randomB: Double = 3
    var abCounter = 1
    @IBAction func addNumbers(_ sender: NSToolbarItem) {
        if randomA > 99999 || randomB > 999999 { randomA = 2; randomB = 3 }

        runScript(.index(.addNumbers(randomA, randomB)))
        
        randomA = randomA * 2
        randomB = randomB * 2
    }
    
    let devices = TypeScript.index.Device.self
    var deviceCount = 0
    @IBAction func selectDevice(_ sender: NSToolbarItem) {
        var device = devices.phone
        if deviceCount < 1 { device = devices.pad; deviceCount += 1 } else
        if deviceCount < 2 { device = devices.mac; deviceCount += 1 }
        else { deviceCount = 0 }
        
        runScript(.index(.selectDevice(device)))
    }
    
    @IBAction func setMode(_ sender: NSToolbarItem) {
        Notifications.javaScript = "toggleMode();"
        Notifications.post(.willRunScript)
    }
    
}
