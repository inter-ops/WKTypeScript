//
//  URL+Extension.swift
//  Shared
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Foundation

extension URL {
    /// Converts `URL` to Optional `String`
    func toString() -> String {
        return self.absoluteString
    }
    /// Returns `true` if `URL` is secure
    func isSecure() -> Bool {
        let string = self.toString()
        if string.contains("https://") { return true }
        else { return false }
    }
}
