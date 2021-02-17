//
//  WKJavaScript.swift
//  Inter-Ops/WKTypeScript
//
//  Generated with WKTypeScript v0.0.1
//
//  THIS FILE WAS AUTOMATICALLY GENERATED AND SHOULD NOT BE TOUCHED.
//

import Foundation

extension WKTypeScript {
    
    /// **JavaScript Utility Functions:** Helper functions to format the JavScript code before execution.
    struct JS {
        static func toString(_ variable: String) -> String {
            // TODO: add postMessage callback
            return "\(variable).toString();"
        }
        /// Removes the `.js` (or `.ts`) extension from the file name (ie. `"index.js" -> "index"`).
        static func removeExtension(_ file: String) -> String {
            let fileName = file.replacingOccurrences(of: ".js", with: "")
            return fileName.replacingOccurrences(of: ".ts", with: "")
        }
    }
    
}
