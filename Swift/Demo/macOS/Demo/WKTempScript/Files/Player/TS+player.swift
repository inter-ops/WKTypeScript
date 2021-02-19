//
//  TS+Global.swift
//  Inter-Ops/WKTypeScript
//
//  global.ts
//  Generated with WKTypeScript v0.0.1
//
//  THIS FILE WAS AUTOMATICALLY GENERATED AND SHOULD NOT BE TOUCHED.
//

import Foundation

extension TypeScript {
    /// `player.ts:` functions and variables
    enum player {
        // MARK: Functions
        case title
        case pause(Void = ())
        case isPlaying(Void = ())
        case getTitle(Void = ())
        case getDuration(Void = ())
        /// Raw JavaScript-generated code to `evaluate` in some WKWebView.
        var js: String {
            switch self {
            case .title: return TSUtility.toString("title")
            case .pause: return "pause();"
            case .isPlaying: return "isPlaying();"
            case .getTitle: return "getTitle();"
            case .getDuration: return "getDuration();"
            }
        }
    }
}
