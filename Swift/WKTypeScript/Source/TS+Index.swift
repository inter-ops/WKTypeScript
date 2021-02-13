//
//  TS+Index.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  THIS FILE WAS GENERATED WITH WKTYPESCRIPT.
//  DO NOT TOUCH THIS FILE.
//

import Foundation

// MARK: index.ts

struct TSIndex {
    
    // MARK: Functions: index.ts
    struct Functions {
        
        static func toggle() -> String { return "toggle();" }
        static func setLabel(_ text: String) -> String { return "setLabel(\(text));" }
        static func hideObject(_ hidden: Bool = false) -> String { return "hideObject(\(hidden));" }
        static func addNumbers(_ a: Double, _ b: Double) -> String { return "addNumbers(\(a), \(b));" }
        static func selectDevice(_ device: Constants.Device) -> String { return "selectDevice(\(device.rawString));" }
        
    }
    
    // MARK: Constants: index.ts
    struct Constants {
        
        public enum Device {
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
