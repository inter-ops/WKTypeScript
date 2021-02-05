//
//  TypeScript.swift
//  Example
//
//  Created by Justin Bush on 2021-02-05.
//

import Foundation

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
    
    /*
    var index = Index.self
    enum Index {
        case toggle
        case setLabel
        case addInts
        
        var function: String {
            switch self {
            case .toggle: return "toggle"
            case .setLabel: return "setLabel"
            case .addInts: return "addInts"
            }
        }
        
        var parameters: Int {
            switch self {
            case .toggle:   return 0        // toggle();            -> 0 parameters (void)
            case .setLabel: return 1        // setLabel(String)     -> 1 parameter
            case .addInts:  return 2        // addInts(Int, Int)    -> 2 parameters
            }
        }
    }
    
    //enum InsertJSON
    
    enum Call {
        
        case file(File)
        case function(Function)
        
        
        enum File {
            case index
            case insertJSON
            
            var function: String {
                switch self {
                case .index:
                    print("Index.ts functions")
                    return ""
                case .insertJSON:
                    print("InsertJSON.ts functions")
                    return ""
                }
            }
        }
    }
    */
}

struct Function {
    
    static func toggle() -> String { return "toggle();" }
    // IF function has one parameter, make first parameter call hidden with _: "(_ {param}: Type)"
    // ie. index.ts: setLabel(text: string) {...}
    //    -> .swift: setLabel(_ text: String) -> String {...}
    static func setLabel(_ text: String) -> String { return "setLabel(\(text));" }
    
    static func hideLabel(_ hidden: Bool) -> String { return "hideLabel(\(hidden));" }
    
    static func addNumbers(a: Double, b: Double) -> String { return "addNumbers(\(a), \(b);" }
    
    // IF function has no parameters (void) -> reference static func for Swifty syntax
    // This allows for: webView.ts(Function.toggle()) => webView.ts(.toggle)
    enum Void {
        case toggle
        var ts: String {
            switch self {
            case .toggle:   return Function.toggle()
            
            }
        }
    }
    
    
    
    static func builder(_ function: String, parameters: String = "") -> String {
        var js = function               // > "toggle"
        
        var jsParameter = parameters    // Single parameter
        var jsParameters = [String]()   // Multiple parameters
        
        let splitKey = ","              // Split parameter by comma
        
        // Void function: No input parameters
        if parameters.isBlank() {
            js.append("();")            // > "toggle();"
        }
        // Non-void function: Extract input parameters
        else {
            // Function contains single parameter
            if !parameters.contains(splitKey) {
                //jsParameter = jsParameter.replacingOccurrences(of: " ", with: "")    // Remove unintentional spaces
                jsParameter = formatParameter(parameters)
                js.append("(\(jsParameter);")   // toggle( jsParameter );"
            }
            // Otherwise, function contains multiple parameters
            else {
                jsParameters = parameters.components(separatedBy: splitKey)     // ["arg1", " arg2", " arg3 "]
                var parameterArray = [String]()
                for param in jsParameters {
                    parameterArray.append(formatParameter(param))
                }
                js.append("(")
                js.append(parameterArray.joined(separator: "\(splitKey) "))
                js.append(");")
            }
        }
        
        return js
    }
    
    static func formatParameter(_ parameter: String) -> String {
        let space = " "
        var output = String()
        while parameter.hasPrefix(space) || parameter.hasSuffix(space) {
            if parameter.hasPrefix(space) {
                output = String(parameter.dropFirst())
            }
            if parameter.hasSuffix(space) {
                output = String(parameter.dropFirst())
            }
        }
        return output
    }
    
    
    
    struct IndexTS {
        //static func toggle() { return "toggle" }
    }
}

/*
enum Functions {
    enum IndexTS {
        case toggle
        case setLabel(String)
        case addCounter(Int)
        
        var function: String {
            switch self {
            case .toggle:   return "toggle"
            case .setLabel(<#T##String#>)
            }
        }
    }
}
 */



//
//struct TypeScript {
//
//    /*
//    static let files = Files.self
//    enum Files {
//        case index
//        case insertJSON
//    }
//    */
//    //static func function(_ function: Function)
//
//}
//
//
//var files = Files.self
//enum Files {
//    case index
//    case insertJSON
//
//    init() {
//        self = .index
//    }
//
//    enum Functions {
//
//    }
//}
//
