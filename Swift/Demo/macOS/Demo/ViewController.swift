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
        
        
        /*
        webView.ts(index: .addNumbers(1, 2), completionHandler: { (result) in
            switch result {
                    case .failure(let error): print(error)
                    case .success(let value): print(value, type(of: value)) // 3 String
                }
        })
        */
    }
    
    // MARK: WebKit Config
    /// Initializes the main WKWebView object.
    func initWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.configuration.userContentController.add(self, name: "eventListeners")
        webView.load(file: "index", path: "Shared/WebContent")
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





// MARK:- Demo Extensions

// MARK: WKWebView Extensions
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
    
    func clearAllCache() {
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
}

