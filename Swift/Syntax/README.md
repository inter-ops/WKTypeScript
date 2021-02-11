# WKTypeScript Syntax

WKTypeScript makes it so that all you need to focus on is either TypeScript/JavaScript or Swift. No more hours spent on implementing and testing raw JavaScript, while debugging the Swift console for more info.

Simply create your TypeScript file, fire `npm run build` and you're good to start implementing in Swift!

<table><tr>
  <th>Create in TypeScript</th>
  <th>Generate to Swift</th>
</tr>
<tr><td>
            
```ts
function toggle() {}
function setLabel(text: string) {}
function addNumbers(a: number, b: number) {}
function userStatus(name: string, verified: boolean) {}

// Polymorphic function
function userStatus(
    name: string = "John",
    verified: boolean = false
){}
```
        
</td><td>

```swift
.toggle()
.setLabel(_ text: String)
.addNumbers(a: Double, b: Double)
.userStatus(name: String, verified: Bool)

// Polymorphic function
class UserStatus {
    var name: String? = "John"
    var verified: Bool? = false
}
```

</td></tr></table>

### Brief Usage Example

<table><tr>
  <th>Call in TypeScript</th>
  <th>Call in Swift</th>
</tr>
<tr><td>
            
```ts
toggle()
setLabel("Hello, world!")
addNumbers(5, 10)
userStatus(name: "John", verified: true)

// Polymorphic function
userStatus("John", true)
```
        
</td><td>

```swift
webView.ts(.toggle())
webView.ts(setLabel("Hello, world!"))
webView.ts(.addNumbers(5, 10))
webView.ts(.userStatus("John", true))

// Polymorphic function
webView.ts(.userStatus("John" ?? "", true ?? false))
```

</td></tr></table>

## Files

#### Swift
```swift
public enum TypeScript {

    case index          // index.ts
    case user           // user.ts
    
    var file: TypeScript<File> {
        switch self {
        case .index: return TypeScript.Index
        case .user:  return TypeScript.User
        }
    }
    
}
```

This will allow you to make calls to functions of specific TypeScript files. i.e: 

`webView.ts(.index.toggle())` and `webView.ts(.user.getStatus(name: "John"))`

## Parsing

### Basic Functions

<table><tr>
  <th>TypeScript</th>
  <th>Swift</th>
</tr>
<tr><td>
            
```ts
function voidFunction() {}
function boolFunction(with: boolean) {}
function stringFunction(with: string) {}
function doubleFunction(a: number, b: number) {}
```
        
</td><td>

```swift
func voidFunction()
func boolFunction(_ with: Bool)
func stringFunction(_ with: String)
func doubleFunction(a: Double, b: Double)
```

</td></tr></table>

#### `index.ts` → `TS+Index.swift`

The package will parse `index.ts` and generate `TS+Index.swift`:

```swift
public enum Index {
    case voidFunction
    case boolFunction(_ with: Bool)
    case stringFunction(_ with: String)
    case doubleFunction(a: Double, b: Double)
    
    var js: String {
        switch self {
        case .voidFunction:             return "voidFunction();"
        case .boolFunction(let with):   return "boolFunction(\(with));"
        case .stringFunction(let with): return "stringFunction(\"\(with)\");"
        case .doubleFunction(let a, b): return "doubleFunction(\(a), \(b));"
        }
    }
    
    public static let ts = "index.ts"
}
```

#### Usage

```swift
let webView = WKWebView()

webView.ts(.voidFunction)
webView.ts(.boolFunction(true))
webView.ts(.stringFunction("Hello, world!"))
webView.ts(.doubleFunction(5, 10))
```

### Overload Functions

Due to the nature of Swift `enum`s, we have to get crafty with polymorphic functions in OOP.

<table><tr>
  <th>TypeScript</th>
  <th>Swift</th>
</tr>
<tr><td>
            
```ts
// Single declaration
function userStatus(
    name: string = "John",
    verified: boolean = false)
    
// Or, multi-declaration
function userStatus() {}
function userStatus(name: string) {}
function userStatus(verified: boolean) {}
function userStatus(name: string, verified: boolean) {}
```
        
</td><td>

```swift
class UserStatus {
    var name: String?
    var verified: Bool?
    
    init(name: String)
    init(verified: Bool)
    init(name: String, verified: Bool)
    
    func js(_ params: UserStatus) -> String
}
```

</td></tr></table>


#### `user.ts` → `TS+User.swift`

The package will parse `user.ts` and generate `TS+User.swift`:

```swift
public enum User {
    case userStatus(UserStatus)
    
    var js: String {
        switch self {
        case .userStatus(let params): return UserStatus.js(params) 
        }
    }
    
    public class UserStatus {
        var name: String? = ""
        var verified: Bool? = false
        
        init(name: String) { self.name = name }
        init(verified: Bool) { self.verified = verified }
        init(name: String, verified: Bool) { self.name = name; self.verified = verified }
        
        // TODO: Implement global param manager and raw JS function builder
        static func js(_ params: User.UserStatus) -> String {
            var script = "multiFunction("
            if let name = params.name { script.append("\(name), ") }
            if let verified = params.verified { script.append("\(verified)") }
            script.append(");")
            return script
        }
    }
}
```

#### Usage

```swift
let webView = WKWebView()

webView.ts(.userStatus())
webView.ts(.userStatus(name: "John"))
webView.ts(.userStatus(verified: true))
webView.ts(.userStatus(name: "John", verified: true)
```

TODO: More function examples

## TODO: Extensions
