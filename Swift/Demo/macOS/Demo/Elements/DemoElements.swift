//
//  DemoElements.swift
//  Demo (macOS)
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Foundation

enum DemoElements {
    case toggle
    case setLabel
    case hideObject
    case addNumbers
    case selectDevice
    case setMode
    case toggleMode
    
    var title: String {
        switch self {
        case .toggle:       return "Toggle"
        case .setLabel:     return "Set Label"
        case .hideObject:   return "Hide Object"
        case .addNumbers:   return "Add Numbers"
        case .selectDevice: return "Select Device"
        case .setMode:      return "Set Mode"
        case .toggleMode:   return "Preview in Mode"
        }
    }
    
    var icon: String {
        switch self {
        case .toggle:       return "switch.2"
        case .setLabel:     return "text.cursor"
        case .hideObject:   return "eye.slash"
        case .addNumbers:   return "plus.slash.minus"
        case .selectDevice: return "laptopcomputer.and.iphone"
        case .setMode:      return "lightbulb"
        case .toggleMode:   return "circle.righthalf.fill"
        }
    }
    
    var description: String {
        switch self {
        case .toggle:
            return "Make simple calls to your TypeScript functions."
        case .setLabel:
            return "Call functions through native Swift with arguments and proper types."
        case .hideObject:
            return "Manipulate web content within the WebView using TypeScript."
        case .addNumbers:
            return "Interact with a web interface to provide it with input data and listen for a result."
        case .selectDevice:
            return "Control (pretty much) any web content with JavaScript evaluation."
        case .setMode:
            return "Modify entire pages with your custom styling code."
        case .toggleMode:
            return "Preview the demo in light or dark mode. The full implementation can be found below."
        }
        
    }
    
    var code: String {
        switch self {
        case .toggle:
            return "toggle()"
        case .setLabel:
            return "setLabel(text: string)"
        case .hideObject:
            return "hideObject(hidden = false)"
        case .addNumbers:
            return "addNumbers(a: number, b: number)"
        case .selectDevice:
            return "selectDevice(device: Device)"
        case .setMode:
            return "setMode(mode = Mode.Light)"
        case .toggleMode:
            return "setMode(.Light | .Dark)"
        }
    }
    
    var codeSwift: String {
        switch self {
        case .toggle:
            return "webView.ts(.toggle)"
        case .setLabel:
            return "setLabel(_ text: String)"
        case .hideObject:
            return "hideObject(_ hidden: Bool = false)"
        case .addNumbers:
            return "addNumbers(a: Double, b: Double)"
        case .selectDevice:
            return "selectDevice(_ device: Device)"
        case .setMode:
            return "setMode(_ mode: Mode = .light)"
        case .toggleMode:
            return "setMode(Mode.light)"
        }
    }
    
}
