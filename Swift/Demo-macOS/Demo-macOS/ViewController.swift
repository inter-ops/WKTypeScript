//
//  ViewController.swift
//  Demo-macOS
//
//  Created by Justin Bush on 2021-02-16.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTests()
    }
    
    func runTests() {
        //Autocomplete Appears: TypeScript.index(TSIndex)
        //print(TypeScript.index(.myFunc(true)))
        //TypeScript.index.staticFunc()
        
        // Load file
        webView.load(.index)
        webView.ts(load: .index)
        
        // Call function
        //webView.ts(.index(.anotherFunc(true)))
        //webView.index(.anotherFunc(true))
        
        // Get variable
        //webView.index(.variable)
        
        webView.async {
            print("Hello, world!")
        }

        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension WKWebView {
    
    //func ts()
    
    func async(await: WKTypeScript.index) {
        
    }
    
    func async(done: () -> Void) {
        print("Async start")
        // track function id
        // wait for function return
        done()
    }
    
    func async(arg: WKTypeScript.index, completion: (Bool) -> ()) {
        print("First line of code executed")
        // do stuff here to determine what you want to "send back".
        // we are just sending the Boolean value that was sent in "back"
        //completion(arg)
    }
    
    // Load ts file
    func load(_ file: WKTypeScript.File) {}
    func ts(load: WKTypeScript.File) {}
    
    // Call functions
    // webView.ts(.index(.anotherFunc(true)))
    func ts(_ function: WKTypeScript.Function) {}
    
    // Call functions by file name
    func global(_ variable: WKTypeScript.index) {}
    func index(_ function: WKTypeScript.index) {}
}

