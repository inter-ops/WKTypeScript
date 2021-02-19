# Callbacks

## Overview

Let's say we have the following TypeScript code, `player.ts`, to evaluate in some `WKWebView` object:

### TypeScript
```ts
let title = "I Gotta Feeling"
function pause()     { /* pause player */ }    // void: pauses the player
function isPlaying() { return true }           // boolean: player state
function getTitle()  { return title }          // string: song name
function duration()  { return 289.0 }          // number: song length in seconds
// function with parameter
function share(to: string) { /* share code ${to}; on success: */ return true }
```

Now let's say that we wanted to perform certain actions, in native Swift, based on the property value of said player attributes...

<hr />

### Swift
Upon `npm run build`, WKTypeScript will perform two tasks with `player.ts`:

#### 1. Generate the File/Function Structure
This will generate the main, controlling Swift file for all things TypeScript. It will implement a `File/Function` model as the root of the structure. The generator will (try its best to) match the project environment so that you can quickly go from compiling your TypeScript to implementing it in native Swift.

In a brief, this is how we'll be loading TypeScript files into our WKWebView objects, as well as making calls to those functions and variables from their respective files:

**`WKTypeScript.swift`**
```swift
struct WKTypeScript {
    // ts files
    enum File: String {
        case player = "player"    // player.ts
    }
    // ts body content
    enum Function {
        case player(player)
        var js: String { switch self { case .player(let io): return io.js }}
    }
}
```

<details>
  <summary> (Expand for Full Code Implementation)</summary>
  
```swift
struct WKTypeScript {
    
    enum File: String {           // reference to files of compiled JavaScript
        case player = "player"    // player.ts
    }
    
    enum Function {               // file-specific body (functions and variables)
        case player(player)       // allows for syntax, ie: .player(.pause())
        
        var js: String {          // the raw JavaScript code to be evaluated
            switch self {
            case .player(let io): return io.js
            }
        }
    }
}
```
  The core of WKTypeScript. Your workspace will be parsed and WKTS will generate a file/function structure, based on the structure of your developing environment. It is here, that all of your TypeScript code – generated for native Swift – can be found.

  After initially generating this file for the first time, WKTS will automatically find new TypeScript files and add them upon the next build.
</details>



#### 2. Generate TypeScript Body
This will generate a parsed-Swift file, for each TypeScript file in your workspace, with all of the body content embedded as native, type-safe functions.

Each file in your workspace is added as a child under the core WKTypeScript controller. For example, let's generate `player.ts`:

**`TSFiles/TSPlayer.swift`**
```swift
enum player {
    // variables
    case title
    // void functions
    case pause(), isPlaying(), getTitle(), duration()
    // functions with parameters
    case share(to: String)
    }
    // raw JS to evaluate
    var js: String {
        switch self {
        case .title:     return "title;" 
        case .pause:     return "pause();"
        case .isPlaying: return "isPlaying();"
        case .getTitle:  return "getTitle();"
        case .duration:  return "duration();"
        case .share(let io): return "share(\"\(io)\");"
        }
    }
}
```

<details>
  <summary> (Expand for Full Code Implementation)</summary>
  
```swift
extension WKTypeScript {
    enum player {
        case title
        case pause(Void = ())
        case isPlaying(Void = ())
        case getTitle(Void = ())
        case duration(Void = ())
        case share(_ to: String)
    }
    
    var js: String {
        switch self {
        case .title:     return "title;" // maybe wrap in postMessage() or custom JS function for callback value?
        case .pause:     return "pause();"
        case .isPlaying: return "isPlaying();"
        case .getTitle:  return "getTitle();"
        case .duration:  return "duration();"
        case .share(let io): return "share(\"\(io)\");"
        }
    }
}
```
</details>

<hr />

### Usage in Swift <sup>up to this point</sup>

```swift
let webView = WKWebView()

// load player.ts in webView
webView.load(.player)            // webView.ts(load: .player)

// run pause()
webView.ts(player: .pause())     // webView.ts(.player(.pause()))
```

Okay, great. I can call upon my TypeScript functions... but, what if I wanted to receive a return value to act on (ie. check if music is currently playing in the player)? We have already implemented the  `isPlaying()` function in our TypeScript file.

Let's say that we wanted to play some other media content – perhaps a video – but only once the music has stopped. How do we go about:

- Checking if the player is currently playing music
- Communicate that between JavaScript and Swift
- Interpreting the return value in Swift
- Perform some functionality in Swift, based on the return value

Let's implement the functionality in Swift first:

```swift
func presentVideo(isPlayingMusic: Bool) {
    if isPlayingMusic {                 // if music is still playing
        webView.ts(player: .pause())    // run our pause() function
    }
    // show video & play video
}
```

Now let's implement some callback methods to bridge the gap between TypeScript and Swift:

#### Classical Method

```swift
webView.evaluateJavaScript(.player(.isPlaying())) { (result) in
    if let playerState = result as? Bool {
        presentVideo(isPlayingMusic: playerState)
    }
}
```

#### TODO<sup>v2</sup> WKTS Method

```swift
webView.ts(player: .isPlaying()) {
    presentVideo(isPlayingMusic: $return)
}
```

What about functions with parameters? `webView.ts(player: .share("Mike") {...}`

<hr />

## TODO: Cleanup and finish the rest of this `.md`

## Further Implementation

### TypeScript Implementation

Let's say we have the following TypeScript file ([view raw file](Swift/Syntax/CallbackSampleFile.ts)) to evaluate in some `WKWebView` object:

```ts
// variables
function returnBool()   { return true }
function returnString() { return "Hello" }
function returnNumber() { return 14 }

// arrays
function returnBoolArray()   { return [true, false, false, true] }
function returnStringArray() { return ["John", "Male", "35"] }
function returnNumberArray() { return [1, 2, 3, 4, 5, 6, 7, 8, 9] }
```

We've also included some WebKit event listeners for sending any value as a `String` literal:
```ts
function postMessageTest() {
  window.webkit.messageHandlers.eventListeners.postMessage(`returnBool: ${returnBool()}`)
  window.webkit.messageHandlers.eventListeners.postMessage(`returnString: ${returnString()}`)
  window.webkit.messageHandlers.eventListeners.postMessage(`returnNumber: ${returnNumber()}`)
}

function postMessageTestArray() {
  window.webkit.messageHandlers.eventListeners.postMessage(`returnBoolArray: ${returnBool()}`)
  window.webkit.messageHandlers.eventListeners.postMessage(`returnStringArray: ${returnStringArray()}`)
  window.webkit.messageHandlers.eventListeners.postMessage(`returnNumberArray: ${returnNumberArray()}`)
}
```

### Swift Implementation
```swift
webView.evaluateJavaScript("returnNumber();") { (result) in
    if let result = result as? Double {
        // result = 14.0
    }
}

NOTE: booleans also return as a number value (ie. Double, Int)
```swift
webView.evaluateJavaScript("returnBool();") { (result) in
    if let result = result as? Bool {
        // result = true || false
    }
    if let result = result as? Double {
        // result = 1.0 || 0.0
    }
}
```

For this reason, we should use `if-else` statements for functions with multiple possible return types, giving priority to types like `Bool` (and other, similar non-casting types). In most of these niche cases, `Double` and `Int` will almost always be the last case to check, as most other values can be alternatively represented as a `number`.

```swift
if let result = result as? Bool {...}
else if let result = result as? Double {...}
```

<hr />

## Arrays

```swift
// MARK: TODO
```

## More Examples

Now let's say that we want to return a `boolean` value – as seen in the `returnBool()` function – so that we can work with it as a `Bool` in Swift.

### Example Case
I am going to run some JavaScript code, depending on if the existing web content is in its light or dark mode state. I will start by implementing some function, ie. `isDark()`, that will interact with the web content, get the current mode and return a `Bool`.

#### TypeScript
```ts
function isDark() {
  var bodyStyle = <HTMLElement>document.query...
  if bodyStyle.toString().contains("dark") { return true }
  return false
}
```

#### Swift
```swift
webView.evaluateJavaScript("isDark();") { (result) in
    if let dark = result as? Bool {
        changeColors(forDarkMode: dark)            // dark is your Bool!
        print("Bool: \(String(describing: dark))") // print as a String
    }
}

func changeColors(forDarkMode: Bool) {
    if forDarkMode { /* run JS code for dark mode */ }
    else { /* run JS code for light mode }
}
```

<hr />



## Testing Notes
- Double/Int return `1` if `true`, `0` if `false`
- Int returns `number` without decimal

