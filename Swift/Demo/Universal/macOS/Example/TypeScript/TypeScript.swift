//
//  TypeScript.swift
//  Example
//
//  Created by Justin Bush on 2021-02-05.
//

import Foundation

typealias TS = TypeScript
struct TypeScript {
    
    let functions = Functions.self
    let constants = Constants.self
    
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
