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

        initWebView()
        
    }
    
    // MARK: WebKit Config
    /// Initializes the main WKWebView object.
    func initWebView() {
        webView.uiDelegate = self                           // Set WebView UI Delegate
        webView.navigationDelegate = self                   // Set WebView Navigation Delegate
        // JavaScript Event Listeners
        webView.configuration.userContentController.add(self, name: "eventListeners")
        // Load URL
        webView.load("https://google.com")
    }
    
    
    // MARK: JavaScript Handler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // JavaScript event listeners
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

