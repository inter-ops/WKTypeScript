//
//  WebView.swift
//  WKTSwiftUI-macOS
//
//  Created by Justin Bush on 2021-02-09.
//

import SwiftUI
import WebKit
import Combine

class WebViewData: ObservableObject {
    @Published var loading: Bool = false
    @Published var scrollPercent: Float = 0
    @Published var url: URL? = nil
    @Published var urlBar: String = "https://nasa.gov"
    
    var scrollOnLoad: Float? = nil
}

#if os(macOS)

struct WebView: NSViewRepresentable {
    @ObservedObject var data: WebViewData
    
    func makeNSView(context: Context) -> WKWebView {
        return context.coordinator.webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {

        guard context.coordinator.loadedUrl != data.url else { return }
        context.coordinator.loadedUrl = data.url
        
        if let url = data.url {
            DispatchQueue.main.async {
                let request = URLRequest(url: url)
                nsView.load(request)
            }
        }

        context.coordinator.data.url = data.url
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(data: data)
    }
}

#else

struct WebView: UIViewRepresentable {
    @ObservedObject var data: WebViewData

    func makeUIView(context: Context) -> WKWebView {
        return context.coordinator.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard context.coordinator.loadedUrl != data.url else { return }
        context.coordinator.loadedUrl = data.url
        
        if let url = data.url {
            DispatchQueue.main.async {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }

        context.coordinator.data.url = data.url
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        return WebViewCoordinator(data: data)
    }
}

#endif

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    @ObservedObject var data: WebViewData

    var webView: WKWebView = WKWebView()
    var loadedUrl: URL? = nil
    
    init(data: WebViewData) {
        self.data = data
        
        super.init()
        
        self.setupScripts()
        webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            if let scrollOnLoad = self.data.scrollOnLoad {
                self.scrollTo(scrollOnLoad)
                self.data.scrollOnLoad = nil
            }
            
            self.data.loading = false

            if let urlstr = webView.url?.absoluteString {
                self.data.urlBar = urlstr
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        DispatchQueue.main.async { self.data.loading = true }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showError(title: "Navigation Error", message: error.localizedDescription)
        DispatchQueue.main.async { self.data.loading = false }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showError(title: "Loading Error", message: error.localizedDescription)
        DispatchQueue.main.async { self.data.loading = false }
    }
    
    func scrollTo(_ percent: Float) {
        let js = "scrollToPercent(\(percent))"
        
        webView.evaluateJavaScript(js)
    }
    
    func setupScripts() {
        
        let monitor = WKUserScript(source: ScrollMonitorScript.monitorScript,
                                   injectionTime: .atDocumentEnd,
                                   forMainFrameOnly: true)
        
        let scrollTo = WKUserScript(source: ScrollMonitorScript.scrollTo,
                                   injectionTime: .atDocumentEnd,
                                   forMainFrameOnly: true)
        
        webView.configuration.userContentController.addUserScript(monitor)
        webView.configuration.userContentController.addUserScript(scrollTo)
        
        let msgHandler = ScrollMonitorScript { percent in
            DispatchQueue.main.async {
                self.data.scrollPercent = percent
            }
        }
        
        webView.configuration.userContentController.add(msgHandler, contentWorld: .page, name: "notifyScroll")
    }
    
    func showError(title: String, message: String) {
        #if os(macOS)
        let alert: NSAlert = NSAlert()
        
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .warning

        alert.runModal()
        #else
        print("\(title): \(message)")
        #endif
    }
}

class ScrollMonitorScript: NSObject, WKScriptMessageHandler {
    let callback: (Float) -> ()
    
    static var monitorScript: String {
        return """
                  let last_known_scroll_position = 0;
                  let ticking = false;
                  
                  function getScrollPercent() {
                      var docu = document.documentElement;

                      let t = docu.scrollTop;
                      let h = docu.scrollHeight;
                      let ch = docu.clientHeight

                      return (t / (h - ch)) * 100;
                  }
                  
                  window.addEventListener('scroll', function(e) {
                      window.webkit.messageHandlers.notifyScroll.postMessage(getScrollPercent());
                  });
              """
    }
    
    static var scrollTo: String {
        return """
                  function scrollToPercent(pct) {
                      var docu = document.documentElement;

                      let h = docu.scrollHeight;
                      let ch = docu.clientHeight

                      let t = (pct * (h - ch)) / 100;

                      window.scrollTo(0, t);
                  }
               """
    }
    
    init(callback: @escaping (Float) -> ()) {
        self.callback = callback
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let percent = message.body as? NSNumber {
            self.callback(percent.floatValue)
        }
    }
}
