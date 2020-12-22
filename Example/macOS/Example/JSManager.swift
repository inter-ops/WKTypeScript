//
//  JSManager.swift
//  Example
//
//  Created by Justin Bush on 2020-12-21.
//

import Foundation

// MARK: JavaScript Manager
/// Handles all of the reading and retrieval of JavaScript content from file.
struct JS {
    
    static let index = "index"      // index.js (default)
    static let path = "dist/"       // path/to/js
    
    /// Returns the generated JavaScript code for `index.js` as a String.
    static func get() -> String {
        return get(file: index, path: path)
    }
    /// Returns the generated JavaScript code for a specified JavaScript `file`.
    /// - parameters:
    ///     - file: The name of the JavaScript file you wish to retrieve (file extension is optional)
    /// - returns: The contents of the input JavaScript file as a String
    /// # Usage
    ///     let code = JS.get(file: "index")
    ///     webView.evaluateJavaScript(code)
    static func get(file: String) -> String {
        get(file: file, path: path)
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
    
}

// MARK: String Extension
extension String {
    /// Removes the `.js` extension from the file name (ie. `"index.js" -> "index"`).
    func removeExtension() -> String {
        return self.replacingOccurrences(of: ".js", with: "")
    }
}
