//
//  ViewController.swift
//  Example
//
//  Created by Justin Bush on 2020-12-22.
//

import UIKit
import WebKit

/// Enables debug functions and console logs when `true`
let debug = true

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var toggleModeButton: UIBarButtonItem!

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
        webView.load(file: "index", path: "WebContent")
    }
    /// Clear WebKit WebView object cache.
    func clearCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        run(JS.get())
    }

    // MARK: JavaScript Handler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // JavaScript event listeners
    }
    
    @IBAction func toggleMode(_ sender: UIBarButtonItem) {
        run(Script.toggleMode)
    }

}

// MARK:- WebKit Extension
extension WKWebView {
    /// Override WKWebView safe area insets.
    override open var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
