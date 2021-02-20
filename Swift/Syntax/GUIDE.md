# Generator Guide
We will be using a sample project – inherently modelled after the default WKTypeScript project structure below – to demonstrate the parsing, compiling and generating processes of WKTS.

## Table of Contents
1. **[Project Hierarchy (File Structure)](project-hierarchy-file-structure)**

## Project Hierarchy (File Structure)

```
$PROJECT_ROOT/

    WKTypeScript/                       // Node Package
        src/                            // (Default) TypeScript working directory
            globa.ts
            index.ts
            mode.ts
            player.ts
            
        dist/                           // (Default) transpiled JavaScript destination
            global.js
            index.js
            mode.js
            player.js

    TypeScript/                         // Destination for all generated Swift files
        TypeScript.swift                // Core Controller (file and function references)
        Files/                          // Directory of transpiled TypeScript files
            TS+global.swift             // From: global.ts
            TS+index.swift              // From: index.ts
            TS+mode.swift               // From: mode.ts
            TS+player.swift             // From: player.ts
        Extensions/
            Generated/
                WK+Generated.swift      // Generated WebKit extensions
        Helpers/
            JavaScript.swift
            TSUtility.swift
                
```

<details>
  <summary> Expand for Full File Structure </summary>

```
$PROJECT_ROOT/

    Project.xcodeproj                   // Example Xcode Project
    Project/                            // Example Xcode Directory
        AppDelegate.swift
        ViewController.swift
        ...
        TypeScript/                     // Group reference to generated directory
        WKTypeScript/dist/              // Folder reference to JavaScript directory
        
    TypeScript/                         // Destination of generated Swift files
        TypeScript.swift                // Core WKTS Controller (struct) with file references
        Configuration/
            TSConfig.swift              // WKTS configuration file (ie. dist path)
        Helpers/
            TSUtility.swift             // TypeScript output function manager
            TSFunction.swift            // Passes through before evaluation
        Files/                          // Destination of file.ts → file.swift
            TS+global.swift             // From: global.ts
            TS+index.swift              // From: index.ts
            TS+mode.swift               // From mode.ts
            TS+player.swift             // From: player.ts
        Extensions/
            Generated/
                WK+Generated.swift      // Generated WebKit extensions
            
    WKTypeScript/                       // Node Package (imported)
        package.json                    // Package gunk...
        ...
        src/                            // Default TypeScript working directory
            global.ts
            index.ts
            player.ts
            user.ts
        dist/                           // Default JavaScript output directory
            global.js
            index.js
            player.js
            user.js
```
</details>

<hr />

## Setup

### File Structure
1. Go to `src/` (or custom path?)
2. Get generic TypeScript file names (ie. `index`, `player`, `user`)
3. Create a new directory at project root, `TypeScript`, for generating Swift files:

```
TypeScript/
```

4. Create the core file, `TypeScript.swift`, and its sub-directories:

```
TypeSwift/
    TypeScript.swift
    Files/
    Extensions/
        Generated/
```

5. Exclude TypeScript files that are empty or have no functions
6. Create Swift files, for each of the corresponding TypeScript files, with naming scheme `TS+fileName.swift`:

```
TypeScript/
    TypeScript.swift
    Files/
        TS+global.swift
        TS+index.swift
        TS+mode.swift
        TS+player.swift
```

#### Structure Setup Complete <sup>be proud of yourself, go have a beer</sup>

### TypeScript Body
1. Get single TypeScript file (ie. `index.ts`)
2. Parse file for functions and variables:



<hr />

## Generate

#### `TypeScript.swift`

```swift
struct TypeScript {
    enum File: String {
        case fileA = "fileA"
        case fileB = "fileB"
    }
    
    enum Body {
        case fileA(fileA)
        case fileB(fileB)
        
        var js: String {
            switch self {
            case .fileA(let io): return io.js
            case .fileB(let io): return io.js
    }
}
```
<details>
  <summary> Expand for Full Implementation with Inline Documentation </summary>

```swift
import Foundation

/// **Core WKTypeScript Controller:** All things TypeScript go thorugh this structure.
struct TypeScript {
    
    /// The type-safe Swift code equivalent of the parsed and generated TypeScript files. ie. `index.ts` → `index` (camelCase)
    enum File: String {
        /// `global.ts`
        case global = "global"
        /// `index.ts`
        case index = "index"
        /// `mode.ts`
        case mode = "mode"
        /// `player.ts`
        case player = "player"
    }
    
    enum Body {
        /// `global.ts`
        case global(global)
        /// `index.ts`
        case index(index)
        /// `mode.ts`
        case mode(mode)
        /// `player.ts`
        case player(player)
        
        /// The executable JavaScript code, transpiled from TypeScript, to be evaluated in some WKWebView object.
        var js: String {
            switch self {
            case .global(let io): return io.js
            case .index(let io): return io.js
            case .mode(let io): return io.js
            case .player(let io): return io.js
            }
        }
    }
}
```
</details>

#### `File/TS+fileA.swift`
```swift
extension TypeScript {
    enum fileA {
        case someVariable
        case voidFunction(Void = ())
        case boolFunction(_ elem: Bool)
        case boolFunctionWith(_ elemDefault: Bool = false)
        case stringFunction(_ text: String)
        case numberFunction(_ a: Double)
        case sumNumberFunction(_ a: Double, _ b: Double)
        case enumParamFunction(_ enumName: EnumName)
        
        var js: String {
            switch self {
            case .someVariable: return JS.variable("someVariable")
            case .voidFunction: return JS.function("voidFunction()")
            case .boolFunction(let elem): return JS.function("boolFunction(elem)")
            case .boolFunctionWith(let elemDefault): return JS.function("boolFunction(elemDefault)")
            case .stringFunction(let text): return JS.function("stringFunction(\"\(text)\""))
            ...
            case enumParamFunction(let enumName): return JS.function("\(enumName.js)")
            }
        }
        
        enum EnumName: String {           // enum EnumName {
            case one = "firstValue"       //   One = "firstValue",
            case two = "secondValue"      //   Two = "secondValue" }
            
            var js: String {
                case .one: return "EnumName.One"
                case .two: return "EnumName.Two"
            }
        }
    }
}
```

<details>
  <summary> Expand for Full Implementation with Inline Documentation </summary>

```swift
import Foundation

extension TypeScript {
    /// `index.ts:` functions and variables
    enum index {
        // MARK: Variables
        case anchorDelay
        case actionDelay
        // MARK: Functions
        case toggle(Void = ())
        case setLabel(_ text: String)
        case hideObject(_ hidden: Bool = false)
        case addNumbers(_ a: Double, _ b: Double)
        case selectDevice(_ device: Device)
        /// Raw JavaScript-generated code to `evaluate` in some WKWebView.
        var js: String {
            switch self {
            case .anchorDelay: return JS.variable("anchorDelay")
            case .actionDelay: return JS.variable("actionDelay")
            case .toggle: return JS.function("toggle()")
            case .setLabel(let text): return JS.function("setLabel(\"\(text)\")")
            case .hideObject(let hidden): return JS.function("hideObject(\(hidden))")
            case .addNumbers(let a, let b): return JS.function("addNumbers(\(a), \(b))")
            case .selectDevice(let device): return JS.function("selectDevice(\(device.js))")
            }
        }
        
        // MARK:- enums
        enum Device: String {
            case phone = "iOS"
            case pad = "iPadOS"
            case mac = "macOS"
            
            var js: String {
                switch self {
                case .phone: return "Device.Phone"
                case .pad: return "Device.Pad"
                case .mac: return "Device.Mac"
                }
            }
        }
    }
}
```
</details>

#### `Extensions/Generated/WK+Generated.swift`

Interacts with WKWebView. For each file, create 2 separate functions in 2 separate groupings:

```swift
// Group 1: Function Calls
func ts(fileName: TypeScript.fileName) { js(fileName.js) }

// Group 2: Function Callbacks
func callback<T>(fileName: TypeScript.fileName, completionHandler: ((Result<T, Error>) -> Void)? = nil) {
    evaluateCallback(fileName.js, completionHandler: completionHandler)
}
```

<details>
  <summary> Expand for Full Implementation with Inline Documentation </summary>

```swift
import Foundation
import WebKit

extension WKWebView {
    //
    // MARK:- Generated Calls
    //
    // MARK:- global.ts
    /// Call a function or variable from `global.ts` to be evaluated in some WKWebView object.
    /// - parameters:
    ///     - global: The Swift-generated function or variable from `global.ts`
    /// # Usage
    ///     webView.ts(global: .variable)
    ///     webView.ts(global: .function())
    func ts(global: TypeScript.global) { js(global.js) }
    // MARK:- index.ts
    /// Call a function or variable from `index.ts` to be evaluated in some WKWebView object.
    /// - parameters:
    ///     - index: The Swift-generated function or variable from `index.ts`
    /// # Usage
    ///     webView.ts(index: .variable)
    ///     webView.ts(index: .function())
    func ts(index: TypeScript.index) { js(index.js) }
    // MARK:- mode.ts
    /// Call a function or variable from `mode.ts` to be evaluated in some WKWebView object.
    /// - parameters:
    ///     - mode: The Swift-generated function or variable from `mode.ts`
    /// # Usage
    ///     webView.ts(mode: .variable)
    ///     webView.ts(mode: .function())
    func ts(mode: TypeScript.mode) { js(mode.js) }
    /// Call a function or variable from `player.ts` to be evaluated in some WKWebView object.
    /// - parameters:
    ///     - player: The Swift-generated function or variable from `player.ts`
    /// # Usage
    ///     webView.ts(player: .variable)
    ///     webView.ts(player: .function())
    func ts(player: TypeScript.player) { js(player.js) }
    //
    // MARK:- Generated Callbacks
    //
    // MARK:- global.ts
    /// Call a function or variable from `global.ts` to be evaluated in some WKWebView object.
    /// - parameters:
    ///     - global: The Swift-generated function or variable from `global.ts`
    ///     - completionHandler: Awaits a return value from the function call
    /// # Usage
    ///     webView.ts(global: .variable)
    ///     webView.ts(global: .function())
    ///     // Callbacks
    ///     webView.ts(global: .function()) { (result: Result<String, Error>) in
    ///         switch result {
    ///         case .failure(let error): print(error)
    ///         case .success(let value): print(value)
    ///         }
    ///     }
    func callback<T>(global: TypeScript.global, completionHandler: ((Result<T, Error>) -> Void)? = nil) {
        evaluateCallback(global.js, completionHandler: completionHandler)
    }
    // MARK:- index.ts
    /// Call a function or variable from `index.ts` to be evaluated in some WKWebView object.
    /// - parameters:
    ///     - index: The Swift-generated function or variable from `index.ts`
    ///     - completionHandler: Awaits a return value from the function call
    /// # Usage
    ///     webView.ts(index: .variable)
    ///     webView.ts(index: .function())
    ///     // Callbacks
    ///     webView.ts(index: .function()) { (result: Result<String, Error>) in
    ///         switch result {
    ///         case .failure(let error): print(error)
    ///         case .success(let value): print(value)
    ///         }
    ///     }
    func callback<T>(index: TypeScript.index, completionHandler: ((Result<T, Error>) -> Void)? = nil) {
        evaluateCallback(index.js, completionHandler: completionHandler)
    }
    // MARK:- mode.ts
    /// Call a function or variable from `mode.ts` to be evaluated in some WKWebView object.
    /// - parameters:
    ///     - mode: The Swift-generated function or variable from `mode.ts`
    ///     - completionHandler: Awaits a return value from the function call
    /// # Usage
    ///     webView.ts(mode: .variable)
    ///     webView.ts(mode: .function())
    ///     // Callbacks
    ///     webView.ts(mode: .function()) { (result: Result<String, Error>) in
    ///         switch result {
    ///         case .failure(let error): print(error)
    ///         case .success(let value): print(value)
    ///         }
    ///     }
    func callback<T>(mode: TypeScript.mode, completionHandler: ((Result<T, Error>) -> Void)? = nil) {
        evaluateCallback(mode.js, completionHandler: completionHandler)
    }
    // MARK:- player.ts
    /// Call a function or variable from `player.ts` to be evaluated in some WKWebView object.
    /// - parameters:
    ///     - player: The Swift-generated function or variable from `player.ts`
    ///     - completionHandler: Awaits a return value from the function call
    /// # Usage
    ///     webView.ts(player: .variable)
    ///     webView.ts(player: .function())
    ///     // Callbacks
    ///     webView.ts(player: .function()) { (result: Result<String, Error>) in
    ///         switch result {
    ///         case .failure(let error): print(error)
    ///         case .success(let value): print(value)
    ///         }
    ///     }
    func callback<T>(player: TypeScript.player, completionHandler: ((Result<T, Error>) -> Void)? = nil) {
        evaluateCallback(player.js, completionHandler: completionHandler)
    }
}
```
</details>

