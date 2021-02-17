//
//  TS+Mode.swift
//  Demo-macOS
//
//  Created by Justin Bush on 2021-02-16.
//

import Foundation

extension WKTypeScript {
    /// Functions and variables for `mode.ts`
    enum mode {
        // Variables
        case currentMode
        // Functions
        case setMode(_ with: Bool)
        
        /// Raw JavaScript-generated code to `evaluate` in some WKWebView.
        var js: String {
            switch self {
            case .currentMode: return "currentMode.toString();"
            case .setMode(let io): return "setMode(\(io));"
            }
        }
        
        // MARK: enums and related types
        /// `enum Mode` declared in `mode.ts`
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
