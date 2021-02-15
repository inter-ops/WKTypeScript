//
//  WKTSExtensions.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-15.
//

import Foundation
import WebKit

// MARK:- GENERATED
// DO NOT TOUCH!
extension WKWebView {
    func ts(global: TSGlobal.Functions.Name) {
        evaluateJavaScript(global.js)
    }
    func ts(index: TSIndex.Functions.Name) {
        evaluateJavaScript(index.js)
    }
    func ts(mode: TSMode.Functions.Name) {
        evaluateJavaScript(mode.js)
    }
}
