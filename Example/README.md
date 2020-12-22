# WKTypeScript Example Apps
We have provided two example projects, each running a version of the app optimized for all iOS, iPadOS and macOS platforms. The two projects share the same codebase and present the same web content to be manipulated by the TypeScript code.

## Project Hierarchy
- `iOS/`: Example app for iOS and iPadOS
- `macOS/`: Example app for macOS
- `Shared/`: A shared codebase for the iOS, iPadOS and macOS example projects
- `WebContent/`: A shared example web project presented in all example projects

## Shared
The shared codebase allow for a number of possibilities, with the three most important being:

- **[Script.swift](Shared/Script.swift):** A database of TypeScript functions that allow for us to make type-safe calls, to said functions, through native Swift
- **[JSManager.swift](Shared/WebKit/JSManager.swift):** Handles all content retrieval of the compiled JavaScript (`dist/`)
- **[WKRunScript.swift](Shared/WebKit/WKRunScript):** Handles the execution of the compiled JavaScript code through WebKit

In a brief, the process for running a TypeScript function through a WebKit object:

1. Call a TypeScript function from **Script** (type-safe)
2. **Script** will retrieve the function code via **JSManager**
3. **WKRunSript**'s `run()` method will execute the JavaScript

### [Script.swift](Shared/Script.swift) <sup>enum</sup>
This is where all of the TypeScript functions are configured and stored in plain text. The Script enum allows for us to make calls to a type-safe function that is located in the generated TypeScript file.

In the Example apps, we use a TypeScript function, `toggleMode()`, to manipulate the contents of the WKWebView (see [index.ts](https://github.com/inter-ops/WKTypeScript/blob/main/src/index.ts) for the raw code).

```
enum Script {
    
  case toggleMode
  
  var name: String {
    switch self {
    case .toggleMode: return "toggleMode();"
    }
  }
}
```

Ah! This enum screams high-maintenance! Don't worry...

Each case, as well as their corresponding values, are automatically generated from functions in the TypeScript file. If you plan on using WKTypeScript as intended, you shouldn't have to touch this file ever.

The enumerated implementation, however, allows for us to make type-safe calls to raw TypeScript/JavaScript functions in native Swift.

```
func run(script: Script) {
  webView.evaluateJavaScript(script.name)
  ...
}
```
This implementation will allow us to make type-safe calls to TS/JS functions such as:

```
run(script: .toggleMode)
```

A full implementation of [Script.swift](Shared/Script.swift) can be found in the [Shared](Shared/) directory.

### [JSManager.swift](Shared/WebKit/JSManager.swift) <sup>struct</sup>
**JSManager** – shorted to `JS` in code for quicker access – allows us to retrieve the contents of a compiled JavaScript file and ready it for use with **WKRunScript**.

Since we are using a TypeScript configuration, we have already set the default file and path:

```
struct JS {
  static let index = "index"      // index.js (default)
  static let path = "dist/"       // path/to/js
  ...
}
```
Where `index.js` and `dist/` are both referenced to in the example projects, despite being at the root of this repository.

#### `JS.get()`

Whether it be for generic use cases, or the requirement of all-encompassing functionality compressed into a single file, `JS.get()` is all you need. Once the TypeScript has been transpiled from `index.ts` to `index.js`, this function will return the contents of that compiled JavaScript file at `dist/index.js`.

#### `JS.get(file: String)`
If you are working with multiple TypeScript files for a more spread-out configuration of your project, this variation will return the contents of the input JavaScript file from within the `dist/` directory.

#### `JS.get(file: String, path: String)`
Retrieve the contents of any compiled JavaScript file from the specified custom path.

#### Extensions
Due to the nature of Swift's file retrieval method, the extension of the filename is specifically specified: `Bundle.main.path(forResource: "dist/index", ofType: "js")`.

Because of this, we use a custom extension to remove the `.js` filename extension from the argument:

```
extension String {
  /// Removes the `.js` extension from the file name (ie. `"index.js" -> "index"`).
  func removeExtension() -> String {
    return self.replacingOccurrences(of: ".js", with: "")
  }
}
```

### [WKRunScript.swift](Shared/WebKit/WKRunScript.swift) <sup>extension</sup>
About WKRunScript...