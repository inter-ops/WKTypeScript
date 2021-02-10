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
    
    func ts(_ function: Functions.Void, console: Bool) { ts(function.ts, console: console) }
    
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
    
    /*
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
