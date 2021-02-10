//
//  Constants.swift
//  Example
//
//  Created by Justin Bush on 2021-02-05.
//

import Foundation

struct Constants {
    
    enum Device {
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
    
    enum Mode {
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
