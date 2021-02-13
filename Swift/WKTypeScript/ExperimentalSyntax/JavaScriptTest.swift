//
//  JavaScriptTest.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-11.
//

import Foundation
import WebKit

public enum JavaScriptTest {
    case index      //case index(_ js: JavaScript.index)
    case global     //case global(_ js: JavaScript.global)
    
    public enum Builder {
        //public static func setLabel(_ text: String) -> Function { return Function.setLabel(text) }
        public static func index() -> JavaScriptTest { return JavaScriptTest.index }
        public static func global() -> JavaScriptTest { return JavaScriptTest.global }
    }
    
    public static var make: JavaScriptTest.Builder.Type {
        return JavaScriptTest.Builder.self
    }
}

struct dist {
    static let index = IndexTS.self
}

struct IndexTS {
    static func myFunction() -> String { return "myFunction();" }
    static func myFunction(with: Bool) -> String { return "myFunction(\(with));" }
}



extension ViewController {
    func runJS() {
        // MARK: Load JavaScript file
        webView.load(js: .index)
        //webView.load(index.js)
        //webView.index.js(.load)
        
        // MARK: Call JavaScript function
        //webView.index(.myFunction)
        //webView.index
        
        // webView.js(index.myFunction)
    }
}

extension WKWebView {
    // Includes:
    // func evaluate(_ js: String) { evaluateJavaScript(js) }

    // webView.js(.index)
    func js(_ code: dist) {
        //if code == dist.index
    }
    
    func js(_ code: IndexTS) {
        evaluate(code)
    }
}
