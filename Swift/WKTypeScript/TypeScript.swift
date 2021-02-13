//
//  TypeScript.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  THIS FILE WAS GENERATED WITH WKTYPESCRIPT.
//  DO NOT TOUCH THIS FILE.
//

import Foundation

typealias TS = TypeScript
/// The core controller for everything TypeScript. Load files, call functions and handle function callbacks.
struct TypeScript {
    
    static let global = TSGlobal.self       // global.ts
    static let index = TSIndex.self         // index.ts
    static let mode = TSMode.self           // mode.ts
    
}



// MARK:- TypeScript References
// DO NOT GENERATE: UNDER DEVELOPMENT
extension TypeScript {
    
    // Files in src/ (index.ts = index) camelCase
    enum Files {
        case global         // global.ts
        case index          // index.ts
        case mode           // mode.ts
        
        var rawValue: String {
            switch self {
            case .global:   return "global"
            case .index:    return "index"
            case .mode:     return "mode"
            }
        }
    }
    
    enum Types {
        case void
        case boolean
        case string
        case number
        case array
        
        var swift: Any {
            switch self {
            case .void:     return Void.self
            case .boolean:  return Bool.self
            case .string:   return String.self
            case .number:   return Double.self
            case .array:    return Array<Any>.self
            }
        }
    }
    
}
