//
//  WKRunScript.swift
//  Example
//
//  Created by Justin Bush on 2020-12-22.
//

import Foundation

var jsReturn = ""       // JS Console Response

// MARK: Run Script
// Run JavaScript in WKWebView and handle return values
extension ViewController {
    /// Run JavaScript code in WKWebView with completion handlers `result` and `error`
    /// - Parameters:
    ///     - script: JavaScript code to run (see `Script.swift`)
    ///
    /// **Enable Console Logs:** `debug = true`
    func run(_ script: Script) {
        webView.evaluateJavaScript(script.function) { (result, error) in
            if let result = result as? String {
                if debug { print("Result: \(String(describing: result))") }
            }
            if error != nil {
                if debug { print("Error: \(String(describing: error))") }
            }
        }
    }
    /// Run JavaScript code in WKWebView with return completion handler `result` and `error`
    /// - Parameters:
    ///     - script: JavaScript code to run (see `Script.swift`)
    /// - Returns: `result` or  `error` as String
    ///
    /// **Enable Console Logs:** `debug = true`
    func runWithResult(_ script: Script) -> String {
        webView.evaluateJavaScript(script.function) { (result, error) in
            if let result = result as? String {
                if debug { print("Result: \(String(describing: result))") }
                jsReturn = result
            }
            if error != nil {
                if debug { print("Error: \(String(describing: error))") }
            }
        }
        return jsReturn
    }
    
    // MARK:- Deprecated Run Scripts
    // Reads input JavaScript as String and executes in WebKit
    /// Run JavaScript code in WKWebView with completion handlers `result` and `error`
    /// - Parameters:
    ///     - script: JavaScript code to run (see `Script.swift`)
    ///
    /// **Enable Console Logs:** `debug = true`
    func run(_ script: String) {
        webView.evaluateJavaScript(script) { (result, error) in
            if let result = result as? String {
                if debug { print("Result: \(String(describing: result))") }
            }
            if error != nil {
                if debug { print("Error: \(String(describing: error))") }
            }
        }
    }
    /// Run JavaScript code in WKWebView with return completion handler `result` and `error`
    /// - Parameters:
    ///     - script: JavaScript code to run (see `Script.swift`)
    /// - Returns: `result` or  `error` as String
    ///
    /// **Enable Console Logs:** `debug = true`
    func runWithResult(_ script: String) -> String {
        webView.evaluateJavaScript(script) { (result, error) in
            if let result = result as? String {
                if debug { print("Result: \(String(describing: result))") }
                jsReturn = result
            }
            if error != nil {
                if debug { print("Error: \(String(describing: error))") }
            }
        }
        return jsReturn
    }
    
}
