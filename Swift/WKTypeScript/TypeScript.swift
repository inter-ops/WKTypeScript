//
//  TypeScript.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  THIS FILE HAS GENERATED WITH WKTYPESCRIPT.
//  DO NOT TOUCH THIS FILE.
//

import Foundation

typealias TS = TypeScript

struct TypeScript {
    
    let functions = Functions.self
    let constants = Constants.self
    
    // Files in src/ (index.ts = index) camelCase
    enum Files {
        case index
        
        var rawValue: String {
            switch self {
            case .index: return "index"
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
