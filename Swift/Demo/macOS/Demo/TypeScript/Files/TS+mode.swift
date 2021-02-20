//
//  TS+Mode.swift
//  Inter-Ops/WKTypeScript
//
//  mode.ts
//  Generated with WKTypeScript v0.0.1
//
//  THIS FILE WAS AUTOMATICALLY GENERATED AND SHOULD NOT BE TOUCHED.
//

import Foundation

extension TypeScript {
    /// `mode.ts:` functions and variables
    enum mode {
        // MARK: Variables
        case currentMode
        // MARK: Functions
        case setMode(_ mode: Mode)
        /// Raw JavaScript-generated code to `evaluate` in some WKWebView.
        var js: String {
            switch self {
            case .currentMode: return TSUtility.toString("currentMode")
            case .setMode(let io): return TSFunction.builder("setMode(\(io.rawValue));")
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
