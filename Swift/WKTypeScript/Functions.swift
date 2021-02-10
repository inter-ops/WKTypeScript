//
//  Functions.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  THIS FILE HAS GENERATED WITH WKTYPESCRIPT.
//  DO NOT TOUCH THIS FILE.
//

import Foundation

typealias TSF = Functions
struct Functions {
    
    static var code = ""
    
    static func toggle() -> String { return "toggle();" }
    // IF function has one parameter, make first parameter call hidden with _: "(_ {param}: Type)"
    // ie. index.ts: setLabel(text: string) {...}
    //   -> *.swift: setLabel(_ text: String) -> String {...}
    static func setLabel(_ text: String) -> String { return "setLabel(\(text));" }
    
    // IF function has default parameters, add to enum Void with default balue
    // ie. index.ts: function hideObject(hidden: boolean = false) {...}
    //   -> *.swift: func hideObject(_ hidden: Bool) -> String {...}
    static func hideObject(_ hidden: Bool = false) -> String { return "hideObject(\(hidden));" }
    
    // IF function has more than one parameter, keep regular for easier identification
    // Note: Remember to convert ts.type(number) => swift.type(Double)
    static func addNumbers(a: Double, b: Double) -> String { return "addNumbers(\(a), \(b));" }
    
    // IF function takes enum type as parameter, create enum in Constants.swift
    // ie. index.ts: enum Device { Phone = "iPhone", Pad = "iPad", Mac = "macOS" }
    //               function selectDevice(device: Device) {...}
    //   -> *.swift: func selectDevice(_ device: Constants.Device) -> String {...}
    //  (See Constants.swift for Swift enum implementation)
    static func selectDevice(_ device: Constants.Device) -> String { return "selectDevice(\(device.value));" }
    
    // IF functions enum && has default propery, combine schemas (create enum and add to Void)
    static func setMode(_ mode: Constants.Mode = .light) -> String { return "setMode(\(mode.value));" }
    
    // IF function has no parameters (void) -> reference static func for Swifty syntax
    // This allows for: webView.ts(Function.toggle()) => webView.ts(.toggle)
    enum Void {
        // Void function
        case toggle         // ts: function toggle() {...}
        // Function with default parameter(s)
        case hideObject     // ts: function hideObject(hidden: boolean = false) {...}
        case setMode        // ts: function setMode(mode: Mode = Mode.light) {...}
        
        var ts: String {
            switch self {
            case .toggle:       return Functions.toggle()
            case .hideObject:   return Functions.hideObject()
            case .setMode:      return Functions.setMode()
            }
        }
    }
    
    
}

// MARK:- Functions Helper

struct FunctionHelper {
    
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
    
}
