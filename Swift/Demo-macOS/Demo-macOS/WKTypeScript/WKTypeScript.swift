//
//  WKTypeScript.swift
//  Demo-macOS
//
//  Created by Justin Bush on 2021-02-16.
//

import Foundation

/// Core WKTypeScript  handler
struct WKTypeScript {
    
    enum File {
        case global
        case index
        case mode
    }
    
    enum Function {
        /// `global.ts`
        case global(global)
        /// `index.ts`
        case index(index)
        /// `mode.ts`
        case mode(mode)
        
        var js: String {
            switch self {
            case .global(let io): return io.js
            case .index(let io): return io.js
            case .mode(let io): return io.js
            }
        }
    }
    
    
    
    // MARK: ID'ing for Function Callback?
    // Returns: index(Demo_macOS.TSIndex.myFunc(true))
    /*
     case index(TSIndex)
     var js: String {
     switch self {
     case .index(let ts): return ts.js
     }
     }
     */
    
}
