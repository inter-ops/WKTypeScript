//
//  DemoElements.swift
//  WKTSwiftUI-macOS
//
//  Created by Justin Bush on 2021-02-07.
//

import Foundation

enum DemoElements {
    case toggle
    case setLabel
    case hideLabel
    case addNumbers
    case selectDevice
    case setMode
    
    var title: String {
        switch self {
        case .toggle:       return "Toggle"
        case .setLabel:     return "Set Label"
        case .hideLabel:    return "Hide Label"
        case .addNumbers:   return "Add Numbers"
        case .selectDevice: return "Select Device"
        case .setMode:      return "Set Mode"
        }
    }
    
    var icon: String {
        switch self {
        case .toggle:       return "switch.2"
        case .setLabel:     return "text.cursor"
        case .hideLabel:    return "eye.slash"
        case .addNumbers:   return "plus.slash.minus"
        case .selectDevice: return "laptopcomputer.and.iphone"
        case .setMode:      return "lightbulb"
        }
    }
    
    var description: String {
        switch self {
        case .toggle:
            return "Make simple calls to "
        case .setLabel:
            return "Set Label description"
        case .hideLabel:
            return "Hide Label description"
        case .addNumbers:
            return "Add Numbers description"
        case .selectDevice:
            return "Select Device description"
        case .setMode:
            return "Set Mode description"
        }
    }
    
    var code: String {
        switch self {
        case .toggle:
            return "toggle();"
        case .setLabel:
            return "setLabel(text: string);"
        case .hideLabel:
            return "hideLabel(hidden = false);"
        case .addNumbers:
            return "addNumbers(a: number, b: number);"
        case .selectDevice:
            return "selectDevice(device: Device);"
        case .setMode:
            return "setMode(mode = Mode.Light);"
        }
    }
}
