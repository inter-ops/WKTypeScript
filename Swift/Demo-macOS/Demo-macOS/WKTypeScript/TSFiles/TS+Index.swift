//
//  TS+Index.swift
//  Demo-macOS
//
//  Created by Justin Bush on 2021-02-16.
//

import Foundation

extension WKTypeScript {
    /// Functions and variables for `index.ts`
    enum index {
        // Variables
        case anchorDelay
        case actionDelay
        // Functions
        case toggle(() -> Void)
        case setLabel(_ text: String)
        case hideObjects(_ hidden: Bool = false)
        case addNumbers(_ a: Double, _ b: Double)
        case selectDevice(_ device: Device)
        
        /// Raw JavaScript-generated code to `evaluate` in some WKWebView.
        var js: String {
            switch self {
            case .anchorDelay: return JS.toString("anchorDelay") //"anchorDelay.toString();"
            case .actionDelay: return JS.toString("actionDelay") //"actionDelay.toString();"
            case .toggle: return "toggle();"
            case .setLabel(let text): return "setLabel(\"\(text)\");"
            case .hideObjects(let hidden): return "hideObject(\(hidden));"
            case .addNumbers(let a, let b): return "addNumbers(\(a), \(b));"
            case .selectDevice(let device): return "selectDevice(\(device.rawString));"
            }
        }
        
        
        // MARK:- enums
        
        enum Device {
            case phone
            case pad
            case mac
            
            var rawString: String {
                switch self {
                case .phone:    return "Device.Phone"
                case .pad:      return "Device.Pad"
                case .mac:      return "Device.Mac"
                }
            }
        }
        
    }
}
