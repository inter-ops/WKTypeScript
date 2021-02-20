//
//  ElementTitle.swift
//  Demo
//
//  Created by Justin Bush on 2021-02-10.
//

import SwiftUI

struct ElementTitle: View {
    let element: DemoElements
    //var toggleCode: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ElementTitle_Previews: PreviewProvider {
    static var previews: some View {
        ElementTitle(element: DemoElements.setMode)
    }
}
