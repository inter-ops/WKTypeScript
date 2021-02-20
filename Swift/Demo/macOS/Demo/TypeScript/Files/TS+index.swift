//
//  TS+Index.swift
//  Inter-Ops/WKTypeScript
//
//  index.ts
//  Generated with WKTypeScript v0.0.1
//
//  THIS FILE WAS AUTOMATICALLY GENERATED AND SHOULD NOT BE TOUCHED.
//

import Foundation

extension TypeScript {
    /// `index.ts:` functions and variables
    enum index {
        // MARK: Variables
        case anchorDelay
        case actionDelay
        // MARK: Functions
        case toggle(Void = ())
        case setLabel(_ text: String)
        case hideObjects(_ hidden: Bool = false)
        case addNumbers(_ a: Double, _ b: Double)
        case selectDevice(_ device: Device)
        /// Raw JavaScript-generated code to `evaluate` in some WKWebView.
        var js: String {
            switch self {
            case .anchorDelay: return TSUtility.toString("anchorDelay")
            case .actionDelay: return TSUtility.toString("actionDelay")
            case .toggle: return TSFunction.builder("toggle();")
            case .setLabel(let text): return TSFunction.builder("setLabel(\"\(text)\");")
            case .hideObjects(let hidden): return TSFunction.builder("hideObject(\(hidden));")
            case .addNumbers(let a, let b): return TSFunction.builder("addNumbers(\(a), \(b));")
            case .selectDevice(let device): return TSFunction.builder("selectDevice(\(device.rawValue));")
            }
        }
        
        // MARK:- enums
        enum Device: String {
            case phone = "iOS"
            case pad = "iPadOS"
            case mac = "macOS"
        }
    }
}
