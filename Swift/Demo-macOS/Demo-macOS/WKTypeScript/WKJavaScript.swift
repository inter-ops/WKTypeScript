//
//  WKJavaScript.swift
//  Demo-macOS
//
//  Created by Justin Bush on 2021-02-17.
//

import Foundation

//typealias JS = WKJavaScript
//struct WKJavaScript

extension WKTypeScript {
    
    struct JS {
        // "anchorDelay"
        static func toString(_ variable: String) -> String {
            return "\(variable).toString();"
        }
    }
    
    struct Utility {
        
        // index.anchorDelay.js = "anchorDelay.toString();"
        // anchorDelay
        static func toString(_ code: String) -> String {
            return ""
        }
        
        // Utility.builder(.
        /*
        static func builder(_ function: String, args: String) -> String {
            
        }
        */
        
    }
    
}
