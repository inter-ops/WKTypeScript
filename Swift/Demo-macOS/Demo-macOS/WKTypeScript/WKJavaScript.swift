//
//  WKJavaScript.swift
//  Demo-macOS
//
//  Created by Justin Bush on 2021-02-17.
//

import Foundation

extension WKTypeScript {
    
    /// **JavaScript Utility Functions:** Helper functions to format the JavScript code before execution.
    struct JS {
        static func toString(_ variable: String) -> String {
            // TODO: add postMessage callback
            return "\(variable).toString();"
        }
    }
    
}
