//
//  Settings.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-10.
//

import Foundation

struct Settings {
    
    static func storyboardWarnings(_ show: Bool) {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    
}
