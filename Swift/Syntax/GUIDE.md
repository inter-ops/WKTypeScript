# Generator Guide
We will be using a sample project – inherently modelled after the default WKTypeScript project structure below – to demonstrate the parsing, compiling and generating processes of WKTS.

## Table of Contents
1. **[Project Hierarchy (File Structure)](project-hierarchy-file-structure)**

## Project Hierarchy (File Structure)

```
$PROJECT_ROOT/

    WKTypeScript/                       // Node Package
        src/                            // (Default) TypeScript working directory
            index.ts
            player.ts
            user.ts
        dist/                           // (Default) transpiled JavaScript destination
            index.js
            player.js
            user.js

    TypeSwift/                          // Destination for all generated Swift files
        WKTypeScript.swift              // Core Controller (file and function references)
        TSFiles/                        // Directory of transpiled TypeScript files
            TSIndex.swift               // From: index.ts
            TSPlayer.swift              // From: player.ts
            TSUser.swift                // From: user.ts
            TSAssets/
                WK+Generated.swift      // Generated WebKit extensions
                
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
        TypeSwift/                      // Group reference to generated directory
        WKTypeScript/dist/              // Folder reference to JavaScript directory
        
    TypeSwift/                          // Destination of generated Swift files
        WKTypeScript.swift              // Core WKTS Controller (struct) with file references
        TSFiles/                        // Destination of file.ts → file.swift
            index.swift                 // index.ts (enum)
            player.swift                // player.ts (enum)
            user.ts                     // user.ts (enum)
            TSAssets/
                WK+Generated.swift      // Generated WebKit extensions
            
    WKTypeScript/                       // Node Package
        package.json                    // Package gunk
        ...
        src/                            // Default TypeScript working directory
            index.ts
            player.ts
            user.ts
        dist/                           // Default JavaScript output directory
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
3. Create a new directory at project root, `TypeSwift`, for generating Swift files:

```
TypeSwift/
```

4. Create the core file, `WKTypeScript.swift`, and its sub-directories:

```
TypeSwift/
    WKTypeScript.swift
    TSFiles/
        TSAssets/
```

5. Exclude TypeScript files that are empty or have no functions
6. Create Swift files, for each of the corresponding TypeScript files, with naming scheme `TS+FileName.swift`:

```
TypeSwift/
    WKTypeScript.swift
    TSFiles/
        TS+Index.swift
        TS+Player.swift
        TS+User.swift
        TSAssets/
```

#### Structure Setup Complete <sup>be proud of yourself, go have a beer</sup>

### TypeScript Body
1. Get single TypeScript file (ie. `index.ts`)
2. 

<hr />
