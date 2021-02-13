//
//  WebKit+Extension.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Foundation
import WebKit

extension WKWebView {
    
    func ts(_ function: Function) {
        evaluateJavaScript(function.js)
        //evaluateJavaScript(function)
    }

    /// Executes some void TypeScript function to be executed in a WebKit object.
    /// - Parameters:
    ///     - function: TypeScript function of type `void`
    /// # Usage
    ///     webView.ts(.toggle)  // toggle();
    ///     webView.ts(.setTrue) // setTrue();
    func ts(_ function: Functions.Void) { ts(function.ts) }
    /// Executes some TypeScript function with parameters to be executed in a WebKit object.
    /// # Usage
    ///     let myFunction = Functions.addNumbers(a: 5, b: 10)
    ///     webView.ts(myFunction)
    ///     // TS: addNumbers(5, 10);
    ///
    func ts(_ function: String) {
        evaluateJavaScript(function)
    }
    /// Executes some void TypeScript function to be executed in a WebKit object.
    /// - Parameters:
    ///     - function: TypeScript function of type `void`
    /// # Usage
    ///     webView.ts(.toggle)  // toggle();
    ///     webView.ts(.setTrue) // setTrue();
    func ts(_ function: Functions.Void, console: Bool) { ts(function.ts, console: console) }
    
    /// Executes some void TypeScript function to be executed in a WebKit object.
    /// - Parameters:
    ///     - function: TypeScript function of type `void`
    /// # Usage
    ///     webView.ts(.toggle)  // toggle();
    ///     webView.ts(.setTrue) // setTrue();
    func ts(_ function: String, console: Bool) {
        if console {
            evaluateJavaScript(function) { (result, error) in
                if error != nil {
                    if debug { print("[WKTS] Error: \(String(describing: error))") }
                }
            }
        } else {
            ts(function)
        }
    }
    // UNDER CONSTRUCTION
    func ts(load: TypeScript.Files) -> String {
        return WKWebView.get(file: load.rawValue, path: WKTSConfig.distDir)// load.rawValue
    }
    func load(_ file: TypeScript.Files) {
        let js = WKWebView.get(file: file.rawValue, path: WKTSConfig.distDir)
        evaluateJavaScript(js)
    }
    /// Returns the generated JavaScript code for a specified JavaScript `file`.
    /// - parameters:
    ///     - file: The name of the JavaScript file you wish to retrieve (file extension is optional)
    ///     - path: The path to the directory where the JavaScript file is located
    /// - returns: The contents of the input JavaScript file as a String
    /// # Usage
    ///     let code = JS.get(file: "index")
    ///     webView.evaluateJavaScript(code)
    static func get(file: String, path: String) -> String {
        if let filePath = Bundle.main.path(forResource: "\(path)\(file.removeExtension())", ofType: "js") {
            do {
                let contents = try String(contentsOfFile: filePath)
                return contents
            } catch {
                print("Error: contents could not be loaded")
            }
        } else {
            print("Error: \(file.removeExtension()).js not found")
        }
        return "Error"
    }
    
    /* HACKY: async await
    func ts(_ function script: String, completion: (result: AnyObject?, error: NSError?) -> Void) {
        var finished = false
        
        evaluateJavaScript(script) { (result, error) in
            if error == nil {
                if result != nil {
                    completion(result: result, error: nil)
                }
            } else {
                completion(result: nil, error: error)
            }
            finished = true
        }
        
        while !finished {
            RunLoop.current().run(mode: .defaultRunLoopMode, before: Date.distantFuture)
        }
    }
    */
}
