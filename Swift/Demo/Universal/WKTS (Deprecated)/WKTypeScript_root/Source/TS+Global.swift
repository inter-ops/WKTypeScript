//
//  TS+Global.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  THIS FILE WAS GENERATED WITH WKTYPESCRIPT.
//  DO NOT TOUCH THIS FILE.
//

import Foundation

// MARK: global.ts

struct TSGlobal {
    
    struct Functions {
        
        /// WebKit Event Listeners, Post Message:
        /// Takes some message, as a `String`, and sends it to the Xcode console.
        /// - Parameters:
        ///     - msg: The message to be sent to the Xcode console
        /// - returns: A message, of type `String`, to be printed in the Xcode console, ie. "[WKTS] toggle() success"
        static func postMessage(_ msg: String) -> String { return "postMessage(\(msg));" }
        
        enum Name {
            case postMessage(_ msg: String)
            
            var js: String {
                switch self {
                case .postMessage(let msg): return Functions.postMessage(msg)
                }
            }
        }
        
    }
}
