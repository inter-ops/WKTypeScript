//
//  Function.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-10.
//

import Foundation

// Swift enums with associated default values
// https://ilya.puchka.me/swift-enums-with-associated-values-defaults/
typealias Func = Function
public enum Function {
    
    case toggle
    case setLabel(_ text: String)
    case hideObject(_ hidden: Bool = false)
    case addNumbers(a: Double, b: Double)
    case selectDevice(_ device: Constants.Device)
    case setMode(_ mode: Constants.Mode = .light)
    
    var js: String {
        switch self {
        case .toggle: return "toggle();"
        case .setLabel(let text): return "setLabel(\"\(text)\");"
        case .hideObject(let hidden): return "hideObject(\(hidden));"
        case .addNumbers(let a, let b): return "addNumbers(\(a), \(b));"
        case .selectDevice(let device): return "selectDevice(\(device.value));"
        case .setMode(let mode): return "setMode(\(mode.value));"
        }
    }
    
    public enum Builder {
        public static func setLabel(_ text: String) -> Function { return Function.setLabel(text) }
        public static func hideObject(_ hidden: Bool = false) -> Function { return Function.hideObject(hidden) }
        public static func addNumbers(a: Double, b: Double) -> Function { return Function.addNumbers(a: a, b: b) }
        public static func selectDevice(_ device: Constants.Device) -> Function { return Function.selectDevice(device) }
        public static func setMode(_ mode: Constants.Mode) -> Function { return Function.setMode(mode) }
    }
    
    
    public static var make: Function.Builder.Type {
        return Function.Builder.self
    }
    
    public static let ts = "index.ts"
}

extension ViewController {
    func runTS() {
        webView.ts(.toggle)
        webView.ts(.setLabel("Hello, world!"))
        webView.ts(.hideObject(true))
        webView.ts(.addNumbers(a: 5, b: 10))
        webView.ts(.selectDevice(.mac))
        webView.ts(.setMode(.dark))
        
        // For multi-files
        //webView.ts(Index.toggle)
        //webView.index.ts(.toggle)
    }
}





