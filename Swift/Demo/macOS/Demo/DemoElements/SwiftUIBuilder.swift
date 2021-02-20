//
//  SwiftUIBuilder.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-20.
//

import Foundation

// MARK: SwiftUI to Executable JS
// This is a temporary class that allows for SwiftUI elements to interact with a WebKit object using UIKit or Cocoa.
struct SwiftUIBuilder {
    
    // MARK: Default Values
    static var inputString = ""
    static var inputBool = false
    static var inputA: Double = 5
    static var inputB: Double = 10
    static var inputDevice = TypeScript.index.Device.phone
    static var inputMode = TypeScript.mode.Mode.light
    
    static func set(_ element: DemoElements, value: Any = "") {
        var code = ""
        
        // MARK: Default Type Setters
        if let value = value as? String {
            inputString = "\"\(value)\""
        }
        if let value = value as? Bool {
            inputBool = value
        }
        
        if element == .addNumbers {
            if let value = value as? Array<String> {
                if let a = Double(value.first ?? "0.0") { inputA = a }
                if let b = Double(value.last ?? "0.0")  { inputB = b }
            }
        }
        
        if element == .selectDevice {
            let devices = TypeScript.index.Device.self
            if let value = value as? String {
                if value == "iPhone" { inputDevice = devices.phone } else
                if value == "iPad" { inputDevice = devices.pad } else
                if value == "macOS" { inputDevice = devices.mac }
                else { inputDevice = devices.phone }
            }
        }
        
        if element == .setMode {
            let modes = TypeScript.mode.Mode.self
            if let value = value as? String {
                if value == "Light" { inputMode = modes.light } else
                if value == "Dark" { inputMode = modes.dark }
                else { inputMode = modes.light }
            }
        }
        
        let ts = TypeScript.Body.self
        switch element {
        case .toggle:       code = ts.index(.toggle()).js
        case .setLabel:     code = ts.index(.setLabel(value as! String)).js
        case .hideObject:   code = ts.index(.hideObject(value as? Bool ?? false)).js
        case .addNumbers:   code = ts.index(.addNumbers(inputA, inputB)).js
        case .selectDevice: code = ts.index(.selectDevice(inputDevice)).js
        case .setMode:      code = ts.mode(.setMode(inputMode)).js
        case .toggleMode:   code = ts.mode(.setMode(inputMode)).js
        }
        
        Notifications.javaScript = code
        NotificationCenter.default.post(Notification(name: .willRunScript))
    }
   
}

