//
//  WKExtensions.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

//import Foundation
//import WebKit
//
//// MARK: WKTypeScript Functions
//
//extension WKWebView {
//
//    // MARK:- Load File
//
//    /// Load the generated JavaScript code, of the input TypeScript file, to be evaluated in some WKWebView object.
//    /// - parameters:
//    ///     - load: The Swift-generated name of the specified TypeScript file
//    /// # Usage
//    ///     webView.ts(load: .index)
//    func ts(load: WKTypeScript.File) { evaluateTypeScript(file: load) }
//    /// Load the generated JavaScript code, of the input TypeScript file, to be evaluated in some WKWebView object.
//    /// - parameters:
//    ///     - file: The Swift-generated name of the specified TypeScript file
//    /// # Usage
//    ///     webView.load(.index)
//    func load(_ file: WKTypeScript.File) { evaluateTypeScript(file: file) }
//
//    // MARK:- TypeScript Calls
//
//    /// Make calls to your TypeScript functions and variables to be evaluated in some WKWebView object.
//    /// - parameters:
//    ///     - function: The Swift-generated function or variable
//    /// # Usage
//    ///     webView.ts(.index(.variable))
//    ///     webView.ts(.index(.function())
//    func ts(_ function: WKTypeScript.Function) { js(function.js) }
//    /// Make calls to your TypeScript functions (or variables) to be evaluated in some WKWebView object.
//    /// - parameters:
//    ///     - function: The Swift-generated function or variable
//    /// # Usage
//    ///     webView.function(.index(.variable))
//    ///     webView.function(.index(.function())
//    func function(_ function: WKTypeScript.Function) { js(function.js) }
//
//    // MARK:- Controller Functions
//    /// Evalutes raw JavaScript code in a `WKWebView` object
//    /// - parameters:
//    ///     - script: The JavaScript code that you wish to execute
//    /// # Usage
//    ///     let code = "console.log(var);"
//    ///     webView.js(code)
//    func js(_ script: String) {
//        evaluateJavaScript(script)
//    }
//    func evaluateTypeScript(file: WKTypeScript.File) {
//        evaluateJavaScript(getScriptString(file: file))
//    }
//    /// Returns the raw JavaScript generated-code, as a `String`, from the TypeScript `file`.
//    /// - parameters:
//    ///     - file: The name of the TypeScript file you wish to retrieve (file extension is optional)
//    /// - returns: The contents of the JavaScript file as a `String`
//    /// # Usage
//    ///     let code = getScriptString(file: .index)
//    ///     webView.js(code) // or
//    ///     webView.evaluateTypeScript(code)
//    func getScriptString(file: WKTypeScript.File) -> String {
//        return getScriptString(file: file.rawValue, path: WKTypeScript.Config.dir)
//    }
//    /// Returns the raw JavaScript generated-code, as a `String`, from the specified JavaScript `file`.
//    /// - parameters:
//    ///     - file: The name of the JavaScript file you wish to retrieve (file extension is optional)
//    ///     - path: The path to the directory where the JavaScript file is located, relative to your project directory
//    /// - returns: The contents of the JavaScript file as a `String`
//    /// # Usage
//    ///     let code = getScriptString(file: "index", path: "dist/")
//    ///     webView.js(code) // or
//    ///     webView.evaluateJavaScript(code)
//    func getScriptString(file: String, path: String) -> String {
//        let fileName = WKTypeScript.JS.removeExtension(file)
//        if let filePath = Bundle.main.path(forResource: "\(path)\(fileName)", ofType: "js") {
//            do {
//                let contents = try String(contentsOfFile: filePath)
//                return contents
//            } catch {
//                print("Error: contents could not be loaded")
//            }
//        } else {
//            print("Error: \(fileName).js not found")
//        }
//        return "Error"
//    }
//}
//
//
///* HACKY: async await
//func ts(_ function script: String, completion: (result: AnyObject?, error: NSError?) -> Void) {
//    var finished = false
//
//    evaluateJavaScript(script) { (result, error) in
//        if error == nil {
//            if result != nil {
//                completion(result: result, error: nil)
//            }
//        } else {
//            completion(result: nil, error: error)
//        }
//        finished = true
//    }
//
//    while !finished {
//        RunLoop.current().run(mode: .defaultRunLoopMode, before: Date.distantFuture)
//    }
//}
//*/
