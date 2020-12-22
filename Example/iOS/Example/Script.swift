//
//  Script.swift
//  Example
//
//  Created by Justin Bush on 2020-12-22.
//

import Foundation

enum Script {
    
    case toggleMode
    
    var function: String {
        switch self {
        case .toggleMode: return "toggleMode();"
        }
    }
    
    var code: String {
        switch self {
        case .toggleMode: return getJS(.toggleMode)
        }
    }
    
    func getJS(_ script: Script) -> String {
        // return script function code
        return ""
    }

}

