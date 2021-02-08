//
//  ElementList.swift
//  WKTSwiftUI-macOS
//
//  Created by Justin Bush on 2021-02-07.
//

import SwiftUI

let elements = DemoElements.self
struct ElementList: View {
    @State private var toggleState = false
    @State private var labelText: String = ""
    @State private var hideLabel = true
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    
    var body: some View {
        List {
            
            // MARK: Toggle
            Group {
                VStack {
                    ElementHeader(element: elements.toggle)
                    HStack {
                        Text("Toggle to see what happens")
                        
                        Toggle(isOn: $toggleState) {
                            Text("")
                        }
                        .padding()
                    }
                }
            }
            
            Divider()
            
            // MARK: Set Label
            Group {
                VStack {
                    ElementHeader(element: elements.setLabel)
                    HStack {
                        TextField("Enter text...", text: $labelText)
                        Spacer()
                        Button(action: {
                            print("Inject label text into TextField")
                        }) {
                            Text("Submit")
                        }
                    }
                    .padding()
                }
            }
            
            Divider()
            
            // MARK: Hide Object/Label
            Group {
                VStack {
                    ElementHeader(element: elements.hideLabel)
                    HStack {
                        HStack {
                            Toggle(isOn: $hideLabel) {
                                Text("")
                            }
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                print("Hide object display from WebView")
                            }) {
                                Text("Set Display")
                            }
                        }
                        .padding(.leading, 60)
                    }
                    .padding()
                }
            }
            
            
            
        }
    }
}

struct ElementList_Previews: PreviewProvider {
    static var previews: some View {
        ElementList()
            .previewLayout(.fixed(width: 375, height: 800))
    }
}
