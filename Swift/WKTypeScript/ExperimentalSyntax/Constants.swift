//
//  Constants.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  THIS FILE HAS GENERATED WITH WKTYPESCRIPT.
//  DO NOT TOUCH THIS FILE.
//

import Foundation

public enum Constants {
    
    public enum Device {
        case phone
        case pad
        case mac
        
        var value: String {
            switch self {
            case .phone:    return "Device.Phone"
            case .pad:      return "Device.Pad"
            case .mac:      return "Device.Mac"
            }
        }
    }
    
    /*
    enum Vars {
        case setLabel(_ text: String)
        
        var js: String {
            switch self {
            case .setLabel(self)
            }
        }
    }
    */
    
    public enum Mode {
        case light
        case dark
        
        var value: String {
            switch self {
            case .light:    return "Mode.Light"
            case .dark:     return "Mode.Dark"
            }
        }
    }
    
}

struct Variables {
    
    // MARK: Default Variables
    static var device = Constants.Device.phone
    static var mode = Constants.Mode.light
}
