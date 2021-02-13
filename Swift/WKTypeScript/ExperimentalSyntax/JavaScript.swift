//
//  JavaScript.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-11.
//

import Foundation
import WebKit

public enum JavaScript {

    public enum Files {
        case index
        case global
        
        var file: String {
            switch self {
            case .index:    return JavaScript.index.js
            case .global:   return JavaScript.global.js
            }
        }
        
        public static func index(_ function: JavaScript.index) -> JavaScript.index { return function }
        public static func index(_ function: JavaScript.index) -> String { return function.code }
    }
    
    public static var make: JavaScript.Files.Type {
        return JavaScript.Files.self
    }
    
    public enum index {
        case voidFunction
        case stringFunction(_ text: String)
        case boolFunction(_ state: Bool)

        var code: String {
            switch self {
            case .voidFunction: return "voidFunction();"
            case .stringFunction(let text): return "stringFunction(\"\(text)\");"
            case .boolFunction(let state): return "boolFunction(\(state));"
            }
        }

        public static let js = "index.js"
        
        public static var make: JavaScript.index.Type {
            return JavaScript.index.self
        }
    }

    public enum global {
        case setMode(mode: Constants.Mode = .light)

        var code: String {
            switch self {
            case .setMode(let mode): return "setMode(\(mode));"
            }
        }

        public static let js = "global.js"
    }
    
    /*
    public static var make: Function.Builder.Type {
        return Function.Builder.self
    }
    */
}

/*
extension ViewController {
    func runJSTests() {
        
        // MARK: Load JavaScript file
        webView.load(js: .index)
        //webView.load(index.js)
        //webView.index.js(.load)
        
        // MARK: Call JavaScript function
        //webView.index(.myFunction)
        //webView.index
        
        
        webView.load(JSTester.index.myFunction)
    }
    
}
 */

// webView.index.js(.myFunction)
// JS.index.myFunction
struct JSTester {
    struct index {
        
        enum js {
            case myFunction
            case myFunctionParam(with: Bool)
            
            var code: String {
                switch self {
                case .myFunction: return "myFunction();"
                case .myFunctionParam(let with): return "myFunction(\(with));"
                }
            }
        }
        
        public enum Builder {
            //public static func setLabel(_ text: String) -> Function { return Function.setLabel(text) }
            public static func myFunction() -> JSTester.index.js { return JSTester.index.js.myFunction }
        }
        
        public static var make: JSTester.index.Builder.Type {
            return JSTester.index.Builder.self
        }
        
        /*
        public static var make: Function.Builder.Type {
            return Function.Builder.self
        }
        */
        
//        static let myFunction = "myFunction();"
//        static func myFunction(with: Bool) -> String { return "myFunction(\(with));" }
    }
    
    public enum Builder {
        //public static func setLabel(_ text: String) -> Function { return Function.setLabel(text) }
        //public static func index() -> JSTester { return JSTester.index }
    }
    
    public static var make: JSTester.index.Builder.Type {
        return JSTester.index.Builder.self
    }
}

/*
extension WKWebView {
    
    func evaluate(_ js: String) {
        evaluateJavaScript(js)
    }
    
    // MARK: Load JavaScript file
    func load(js: JavaScript.Files) {
        print(js.file)
    }
    
    // MARK: Call JavaScript function
    func js(_ code: JavaScript.Files) {
        //code.file == JavaScript.index
        //let script = code.file
        //evaluate(script.code)
    }
    
    // MARK: webView.index(.myFunction)
    func index(_ js: JavaScript.index) {
        evaluate(js.code)
    }
    
    func load(_ js: JSTester) {
        //evaluate(js)
        js.
        
    }
    
    
    
    // Roadblock: Cannot use enum on webView for: webView.index.js(.myFunc)
    //webView.index.js(.myFunction)
//    enum index {
//        case js(_ function: JavaScript.index)
//
//        var code: String {
//            switch self {
//            case .js(let function): return function.code
//            }
//        }
//
//        public static func js(_ function: JavaScript.index) {
//            // Error: Instance member 'evaluateJavaScript' of type 'WKWebView' cannot be used on instance of nested type 'WKWebView.index'
//            //self.evaluateJavaScript(function.code)
//        }
//    }
    
    
    
    
    func load(_ file: String, path: String) {
        evaluate(WKWebView.get(file: file, path: path))
    }
    
    
    
}
 */
