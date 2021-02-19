//
//  JSConsoleTests.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-19.
//

import Foundation
import WebKit

extension ViewController {
    
    func runJS(_ script: String) {
        webView.evaluateJavaScript(script) { (result, error) in
            if let result = result as? Bool {
                print("Bool: \(String(describing: result))")
            }
            if let result = result as? String {
                print("String: \(String(describing: result))")
            }
            if let result = result as? Double {
                print("Double: \(String(describing: result))")
            }
            if let result = result as? Int {
                print("Int: \(String(describing: result))")
            }
            
            if let result = result as? [Bool] {
                print("[Bool]: \(String(describing: result))")
            }
            if let result = result as? [String] {
                print("[String]: \(String(describing: result))")
            }
            if let result = result as? [Double] {
                print("[Double]: \(String(describing: result))")
            }
            if let result = result as? [Int] {
                print("[Int]: \(String(describing: result))")
            }
            if error != nil {
                print("Error: \(String(describing: error))")
            }
        }
    }
    
    func testA() {
        self.runJS("returnBool();")
        self.runJS("returnString();")
        self.runJS("returnNumber();")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.runJS("postMessageTest();")
        }
    }
    
    func testB() {
//        self.runJS("returnBoolArray();")
//        self.runJS("returnStringArray();")
//        self.runJS("returnNumberArray();")
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.runJS("postMessageTestArray();")
//        }
        //webView.ts(index: .toggle())
        webView.index(.toggle())
    }
    
    func testC() {
        webView.evaluateJavaScript(testCode) { (result, error) in
            if let result = result as? Bool {
                print("Bool: \(String(describing: result))")
                self.printBool(result)
            }
            if let result = result as? String {
                print("String: \(String(describing: result))")
            }
            if let result = result as? Double {
                print("Double: \(String(describing: result))")
            }
        }
    }
    
    func printBool(_ input: Bool) {
        if input {
            print("returns true!")
        } else {
            print("returns false!")
        }
    }
    
    @IBAction func testA(_ sender: Any) { testA() }
    @IBAction func testB(_ sender: Any) { testB() }
    @IBAction func testC(_ sender: Any) { testC() }
    
}

let testCode = """
returnBool();
"""



let jsConsoleTestCode = """
function returnBool() {
    return true;
}
function returnString() {
    return "Hello";
}
function returnNumber() {
    return 14;
}
function returnBoolArray() {
    return [true, false, false, true];
}
function returnStringArray() {
    return ["John", "Male", "35"];
}
function returnNumberArray() {
    return [1, 2, 3, 4, 5, 6, 7, 8, 9];
}
function postMessageTest() {
    window.webkit.messageHandlers.eventListeners.postMessage("returnBool: " + returnBool());
    window.webkit.messageHandlers.eventListeners.postMessage("returnString: " + returnString());
    window.webkit.messageHandlers.eventListeners.postMessage("returnNumber: " + returnNumber());
}
function postMessageTestArray() {
    window.webkit.messageHandlers.eventListeners.postMessage("returnBoolArray: " + returnBool());
    window.webkit.messageHandlers.eventListeners.postMessage("returnStringArray: " + returnStringArray());
    window.webkit.messageHandlers.eventListeners.postMessage("returnNumberArray: " + returnNumberArray());
}
"""
