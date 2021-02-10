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



