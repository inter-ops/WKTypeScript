//
//  WKTypeScript.swift
//  Inter-Ops/WKTypeScript
//
//  Generated with WKTypeScript v0.0.1
//
//  THIS FILE WAS AUTOMATICALLY GENERATED AND SHOULD NOT BE TOUCHED.
//

import Foundation

/// **Core WKTypeScript Controller:** All things TypeScript go thorugh this structure.
struct WKTypeScript {
    
    typealias file = WKTypeScript.File
    typealias body = WKTypeScript.Body // Body // Function
    typealias function = WKTypeScript.Function
    
    /// The type-safe Swift code equivalent of the parsed and generated TypeScript files. ie. `index.ts` → `index`
    enum File: String {
        /// `global.ts`
        case global = "global"
        /// `index.ts`
        case index = "index"
        /// `mode.ts`
        case mode = "mode"
    }
    
    enum Body {
        /// `global.ts`
        case global(global)
        /// `index.ts`
        case index(index)
        /// `mode.ts`
        case mode(mode)
        
        /// The executable JavaScript code, transpiled from TypeScript, to be evaluated in some WKWebView object.
        var js: String {
            switch self {
            case .global(let io): return io.js
            case .index(let io): return io.js
            case .mode(let io): return io.js
            }
        }
    }
    
    enum Function {
        /// `global.ts`
        case global(global)
        /// `index.ts`
        case index(index)
        /// `mode.ts`
        case mode(mode)
        
        /// The executable JavaScript code, transpiled from TypeScript, to be evaluated in some WKWebView object.
        var js: String {
            switch self {
            case .global(let io): return io.js
            case .index(let io): return io.js
            case .mode(let io): return io.js
            }
        }
    }
}
typealias WKTS = WKTypeScript


// MARK: TODO Function Builders
extension WKTypeScript.Function {
    
    static func builder(_ name: String, _ parameters: String) -> String {
        return "\(name)(\(parameters));"
    }
    
    static func builder(_ name: String, _ parameters: Any) -> String {
        var args = parameters
        if let input = parameters as? String {
            if !input.hasSuffix("\"") || !input.hasSuffix("\"") {
                args = "\"\(input)\""
            }
        }
        return "\(name)(\(args));"
    }
    
}
