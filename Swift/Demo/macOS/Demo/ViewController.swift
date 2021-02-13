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

        clearCache()        // Clear WKCache
        initWebView()       // Initialize WebView
        addObservers()      // Add Observers
    }
    
    override func viewWillAppear() {
        
    }
    
    override func viewDidAppear() {
        if let screenSize = view.window?.screen?.frame {
            //view.window!.setFrame(screenSize, display: true)
            print(screenSize)
        }
    }
    
    
    // MARK: WebKit Config
    /// Initializes the main WKWebView object.
    func initWebView() {
        webView.uiDelegate = self                           // Set WebView UI Delegate
        webView.navigationDelegate = self                   // Set WebView Navigation Delegate
        webView.configuration.userContentController.add(self, name: "eventListeners")
        webView.load(file: "index", path: "Shared/WebContent")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // MARK: TODO Load ts in webView Syntax
        //webView.ts(load: .index.ts)
        //webView.load.ts(.index)
        //webView.load(.index.ts)
        webView.load(.index)
        //webView.load()
    }
    
    
    @objc func runJS(_ notification: Notification) {
        if debug { print("Running JS: \(Functions.code)") }
        webView.ts(Functions.code)
    }
    
    
    // MARK: JavaScript Handler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // JavaScript event listeners
        if message.name == "eventListeners" {
            if let message = message.body as? String {
                if debug { print("> \(message)") }
            }
        }
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}
