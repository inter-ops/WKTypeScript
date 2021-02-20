//
//  Builder.swift
//  Example
//
//  Created by Justin Bush on 2021-02-09.
//

import Foundation

// MARK: SwiftUI to Executable JS
// This is a temporary class that allows for SwiftUI elements to interact with a WebKit object using UIKit or Cocoa.
struct Builder {
    
    // MARK: Default Values
    static var inputString = ""
    static var inputBool = false
    static var inputA: Double = 5
    static var inputB: Double = 10
    static var inputDevice = Constants.Device.phone
    static var inputMode = Constants.Mode.light
    
    static func set(_ element: DemoElements, value: Any = "") {
        var code = ""//Functions.code
        
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
            let devices = Constants.Device.self
            if let value = value as? String {
                if value == "iPhone" { inputDevice = devices.phone } else
                if value == "iPad" { inputDevice = devices.pad } else
                if value == "macOS" { inputDevice = devices.mac }
                else { inputDevice = devices.phone }
            }
        }
        
        if element == .setMode {
            let modes = Constants.Mode.self
            if let value = value as? String {
                if value == "Light" { inputMode = modes.light } else
                if value == "Dark" { inputMode = modes.dark }
                else { inputMode = modes.light }
            }
        }
        
        switch element {
        case .toggle:       code = Functions.toggle()
        case .setLabel:     code = Functions.setLabel(inputString)
        case .hideObject:   code = Functions.hideObject(value as? Bool ?? false)
        case .addNumbers:   code = Functions.addNumbers(a: inputA, b: inputB)
        case .selectDevice: code = Functions.selectDevice(inputDevice)  //(value as! Constants.Device)
        case .setMode:      code = Functions.setMode(inputMode)         //(value as! Constants.Mode)
        case .toggleMode:   code = Functions.setMode(inputMode)
        }
        
        Functions.code = code
        
        //print("Functions.code: \(Functions.code)")
        NotificationCenter.default.post(Notification(name: .willRunJS))
    }
   
}

extension DemoElements {
    
    var defaultValue: Any {
        switch self {
        case .toggle:       return ""
        case .setLabel:     return ""
        case .hideObject:   return false
        case .addNumbers:   return [5, 10]
        case .selectDevice: return Constants.Device.phone
        case .setMode:      return Constants.Mode.light
        case .toggleMode:   return ""
        }
    }
    
}
