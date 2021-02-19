//
//  TypeScript.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-19.
//

import Foundation

// typealias TS = TypeScript
/// **Core WKTypeScript Controller:** All things TypeScript go thorugh this structure.
struct TypeScript {

    //typealias file = File
    //typealias body = Body
    
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
    
    
}
