//
//  ElementHeader.swift
//  Demo (macOS)
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import SwiftUI

struct ElementHeader: View {
    let element: DemoElements
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: element.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 30, height: 30)
            .padding()
            
            VStack(alignment: .leading) {
                Text(element.title)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                /*
                Text(element.description)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
                */
                Text(element.code)
                    .font(.system(.body, design: .monospaced))
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

struct ElementHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ElementHeader(element: DemoElements.toggle)
            ElementHeader(element: DemoElements.setLabel)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
