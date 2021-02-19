//
//  ViewController.swift
//  Demo (macOS)
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import Cocoa
import WebKit

class ViewController: NSViewController, NSWindowDelegate, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {

    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.configuration.userContentController.add(self, name: "eventListeners")
        webView.load("about:blank")
        
        webView.ts(index: .toggle())
        
        webView.ts(index: .addNumbers(1, 2), completionHandler: { (result) in
            switch result {
                    case .failure(let error): print(error)
                    case .success(let value): print(value, type(of: value)) // 3 String
                }
        })
        
        webView.ts(index: ., completionHandler: <#T##((Result<String, Error>) -> Void)?##((Result<String, Error>) -> Void)?##(Result<String, Error>) -> Void#>)
        
        // Completion Handlers
        webView.ts(.index(.toggle())) { (result) in
            switch result {
                case .failure(let error): print(error)
                case .success(let value): print(value, type(of: value)) // 3 String
            }
        }
        
        //webView.ts(index: .addNumbers(1, 2))
        
        //webView.ts(.index(.toggle()))

        
        //WKTS.index.hideObjects(true)
        //webView.ts(index: .toggle())
        
        // webview.ts(index: .toggle()) { (object) in
        //     
        // }

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.js(jsConsoleTestCode)
    }
    
    // MARK: JavaScript Handler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // JavaScript event listeners
        if message.name == "eventListeners" {
            if let message = message.body as? String {
                print("> \(message)")
            }
        }
    }
    
    
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}





// MARK:- TEMP (DELETE)
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
}

