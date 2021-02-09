//
//  ViewController.swift
//  Example
//
//  Created by Justin Bush on 2020-12-19.
//

import Cocoa
import WebKit

class ViewController: NSViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        clearCache()        // Clear WebKit Cache
        initWebView()       // Initialize WebView
        addObservers()      // Add Observers
    }
    
    
    @objc func runJS(_ notification: Notification) {
        if debug { print("Running JS: \(Functions.code)") }
        webView.ts(Functions.code)
        
    }
    
    
    // MARK: WebKit Config
    /// Initializes the main WKWebView object.
    func initWebView() {
        webView.uiDelegate = self                           // Set WebView UI Delegate
        webView.navigationDelegate = self                   // Set WebView Navigation Delegate
        // JavaScript Event Listeners
        webView.configuration.userContentController.add(self, name: "eventListeners")
        webView.load(file: "index", path: "WebContent")
    }
    /// Clear WebKit WebView object cache.
    func clearCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.ts(JS.get())
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


