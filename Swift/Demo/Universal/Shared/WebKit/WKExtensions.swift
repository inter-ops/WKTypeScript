//
//  WKExtensions.swift
//  Example
//
//  Created by Justin Bush on 2021-02-04.
//

import Foundation
import WebKit

// MARK: WKWebView
extension WKWebView {
    /// Quick and short load URL String in a WKWebView
    func load(_ string: String) {
        if let url = URL(string: string) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
    /// Quick and short load URL in a WKWebView
    func load(_ url: URL) {
        let request = URLRequest(url: url)
        load(request)
    }
    /// Quick load a `file` (without `.html`) and `path` to the directory
    /// # Usage
    ///     webView.loadFile("index", path: "Website")
    ///  - parameters:
    ///     - name: Name of the HTML file to load (without `.html`, ie. `"index"`)
    ///     - path: Path where the HTML file is located (`"website"` for `website/index.html`)
    func load(file: String, path: String) {
        if let url = Bundle.main.url(forResource: file, withExtension: "html", subdirectory: path) {
            self.loadFileURL(url, allowingReadAccessTo: url)
            let request = URLRequest(url: url)
            load(request)
        }
    }
    /// Quick load a `file` (without `.html`) and `path` to the directory
    /// # Usage
    ///     webView.loadFile("index", path: "Website")
    ///  - parameters:
    ///     - name: Name of the HTML file to load (without `.html`, ie. `"index"`)
    ///     - path: Path where the HTML file is located (`"website"` for `website/index.html`)
    func loadFile(_ name: String, path: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "html", subdirectory: path) {
            self.loadFileURL(url, allowingReadAccessTo: url)
            let request = URLRequest(url: url)
            load(request)
        }
    }
    
    
//    func evaluate(script: String, completion: (result: AnyObject?, error: NSError?) -> Void) {
//            var finished = false
//
//            evaluateJavaScript(script) { (result, error) in
//                if error == nil {
//                    if result != nil {
//                        completion(result: result, error: nil)
//                    }
//                } else {
//                    completion(result: nil, error: error)
//                }
//                finished = true
//            }
//
//            while !finished {
//                RunLoop.current().run(mode: .defaultRunLoopMode, before: Date.distantFuture)
//            }
//        }
    
//    func run(_ script: Script) {
//        webView.evaluateJavaScript(script.name) { (result, error) in
//            if let result = result as? String {
//                if debug { print("Result: \(String(describing: result))") }
//            }
//            if error != nil {
//                if debug { print("Error: \(String(describing: error))") }
//            }
//        }
//    }
    
}
