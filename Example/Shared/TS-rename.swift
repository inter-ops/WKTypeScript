//
//  TS.swift
//  Example
//
//  Created by Justin Bush on 2021-02-04.
//

import Foundation

/*
struct TS {
    
    var files = TSFiles
    
}
 

enum TSFiles {
    // File Names:
    case index
    case insertJSON
    
}
 */



/*
struct Function {
    
    
    
    static func call(_ a: Any) {
        
    }
    
    enum Call {
        case toggle     // toggle();
        /// Returns the type-safe code of the TypeScript function to be executed in a WebKit object.
        /// # Usage
        ///     let ts = Script.insertJSON(jsonString)
        ///     run(json)
        var js: String {
            switch self {
            case .toggle: return "toggle();"
            }
        }
        
        var type: JSType {
            switch self {
            case .toggle: return JSType.void
            }
        }
    }
    
}
 */

/*
typealias Script = TS
struct TS {
    /// Returns a TypeScript function to be executed in some WebKit object.
    /// # Usage
    ///     run(.toggle)    // toggle();
    ///     let code = TS.get(.toggleMode)
    ///     run(code)
    /*
    static func js(_ function: Function) -> String {
        return function.js
    }*/
    
    static func function(_ function: Function, with: Any) {
        let js = ""
    }
    
    static func postMessage(_ text: String) {
        
    }
}


enum Function {
    
    case toggle
    
    // function add(a: int, b: int) { }
    
    
    /// Returns the type-safe code of the TypeScript function to be executed in a WebKit object.
    /// # Usage
    ///     let ts = Script.insertJSON(jsonString)
    ///     run(json)
    var js: String {
        switch self {
        case .toggle: return "toggle();"
        }
    }
    
    var type: JSType {
        switch self {
        case .toggle: return JSType.void
        }
    }
    
//    var name: String {
//        switch self {
//        case .toggleMode: return "toggleMode();"
//        }
//    }
//
//    var code: String {
//        switch self {
//        case .toggleMode: return JS.get()
//        //case .toggleMode: return getJS(.toggleMode)
//        }
//    }
}
 */

enum JSType {
    case void
    case string
    case int
    case bool
    case array
}
