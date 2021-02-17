//
//  TS+Global.swift
//  Demo-macOS
//
//  Created by Justin Bush on 2021-02-16.
//

import Foundation

extension WKTypeScript {
    /// Functions and variables for `global.ts`
    enum global {
        // Functions
        case postMessage(_ msg: String)
        
        /// Raw JavaScript-generated code to `evaluate` in some WKWebView.
        var js: String {
            switch self {
            case .postMessage(let io): return "postMessage(\"\(io)\");"
            }
        }
        
    }
}
