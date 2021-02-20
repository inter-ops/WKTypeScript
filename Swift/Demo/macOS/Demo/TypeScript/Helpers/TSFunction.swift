//
//  TSFunction.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Foundation

struct TSFunction {
    /// All functions pass through here, as a `String`, before being evaluated as JavaScript.
    static func builder(_ script: String) -> String {
        return script
    }
}
