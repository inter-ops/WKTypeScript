# WKTypeScript Syntax

## Files

#### Swift
```
public enum TypeScript {
    case index     // index.ts
    case user      // user.ts
}
```

## Parsing

### Basic Functions

#### index.ts → TS+Index.swift

<table>
  <tr>
  <th>index.ts</th>
  <th>Swift.json</th>
</tr>
<tr>
<td>
<pre>
{
  "id": 1,
  "username": "joe",
  "email": "joe@example.com",
  "order_id": "3544fc0"
}
</pre>
</td>
<td>

```json
{
  "id": 5,
  "username": "mary",
  "email": "mary@example.com",
  "order_id": "f7177da"
}
```

</td>
</tr>
</table>

```
public enum Index {
    case voidFunction
    case boolFunction(
    case stringFunction
    case doubleFunction
    case structFunction
}
```

#### User.ts -> TS+User.swift

```
struct User {

}
```