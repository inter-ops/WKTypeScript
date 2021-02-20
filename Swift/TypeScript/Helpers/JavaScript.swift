//
//  JavaScript.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-20.
//

import Foundation

typealias JS = JavaScript
struct JavaScript {
    /// All functions pass through here, as a `String`, before being evaluated as JavaScript.
    static func function(_ name: String) -> String {
        return name + ";"
    }
    
    static func variable(_ name: String) -> String {
        return "\(name);" // .toString();"
    }
    
}
