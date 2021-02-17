# WKTypeScript Conversion Guide

## Variables
Variable declarations in TypeScript are identical to those in Swift. `var`, `let` and `const` are all literal translations. However, it is important to note that `let` in Swift encompasses more of TypeScript's `const` than Swift's own `const`(?).



## Types
TypeScript types and their Swift equivalent literal.

<table><tr>
  <th>TypeScript Declaration</th>
  <th>Swift Equivalent</th>
</tr>
<tr><td>
            
```ts
boolean
number
string

// arrays
type[]        // number[] = [1, 2, 3]
Array<type>   // Array<number> = ...

// tuples
[type, type]  // [string, number]
              // ["John", 34]
```
        
</td><td>

```swift
Bool
Double
String

// arrays
[type]        // [Double] = [1, 2, 3]
[type]()      // [Double]() array in question

// tuples
[type, type]  // [String, Double]
              // ["John", 34]
```

</td></tr></table>

<hr />

## Enums
### Notes 
- Convert case naming convention to camelCase, i.e. `RedColor` to `case redColor`
- `enum` cases with no declared type should be declared `Int` by default

<table><tr>
  <th>TypeScript Declaration</th>
  <th>Swift Equivalent</th>
</tr>
<tr><td>
            
```ts
enum Color {
  Red,
  Green,
  Blue
}

// usage
let c: Color = Color.Blue
console.log(c)  // 2
```
        
</td><td>

```swift
enum Color: Int {
    case red
    case green
    case blue
}

// usage
let c: Color = .blue
print(c.rawValue)  // 2
```

</td></tr></table>

### Enums with Type Values
For enums with associated values, we must declare: `enum Name: <type>` so that we can call `Name.case.rawValue`.

In the example below, we can see that an enum, `Device`, has been declared in TypeScript with associated `string` values.

<table><tr>
  <th>TypeScript Declaration</th>
  <th>Swift Equivalent</th>
</tr>
<tr><td>
            
```ts
enum Device {
  Phone = "iOS",
  Pad = "iPadOS",
  Mac = "macOS"
}

// usage
let d: Device = Device.Mac
console.log(d)   // "macOS"
```
        
</td><td>

```swift
enum Device: String {
    case phone = "iOS"
    case pad = "iPadOS"
    case mac = "macOS"
}

// usage
let d: Device = .mac
print(d.rawValue)  // "macOS"
```

</td></tr></table>

<hr />

## Full Implementation
<table><tr>
  <th>TypeScript Declaration</th>
  <th>Swift Equivalent</th>
</tr>
<tr><td>
            
```ts
var a: boolean = true
let b: number = 10
const c: string = "Hello"

enum Planets {
  Mercury,
  Venus,
  Earth,
  Mars
}
```
        
</td><td>

```swift
var a: Bool = true
let b: Double = 10
const c: String = "Hello"

enum Planets: String {
  case mercury 
  case venus
  case earth
  case mars
}
```

</td></tr></table>
