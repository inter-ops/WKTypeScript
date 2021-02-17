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
        case setMode(_ mode: Mode)
        
        /// Raw JavaScript-generated code to `evaluate` in some WKWebView.
        var js: String {
            switch self {
            case .currentMode: return JS.toString("currentMode")        //"currentMode.toString();"
            case .setMode(let io): return "setMode(\(io.rawValue));"    //"setMode(\(io));"
            }
        }
        
        // MARK: enums and related types
        /// `enum Mode` declared in `mode.ts`
        enum Mode: String {
            case light = "Mode.Light"
            case dark = "Mode.Dark"
        }
    }
}
