//
//  TS+Mode.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  THIS FILE WAS GENERATED WITH WKTYPESCRIPT.
//  DO NOT TOUCH THIS FILE.
//

import Foundation

// MARK: mode.ts

struct TSMode {
    
    // MARK: Functions: mode.ts
    struct Functions {
        
        static func setMode(_ mode: Constants.Mode) -> String { return "setMode(\(mode.rawString));" }
        
        enum Name {
            case setMode(_ mode: Constants.Mode)
            
            var js: String {
                switch self {
                case .setMode(let mode): return Functions.setMode(mode)
                }
            }
        }
        
    }
    
    // MARK: Constants: mode.ts
    struct Constants {
        
        public enum Mode {
            case light
            case dark
            
            var rawString: String {
                switch self {
                case .light:    return "Mode.Light"
                case .dark:     return "Mode.Dark"
                }
            }
        }
        
    }
    
}
