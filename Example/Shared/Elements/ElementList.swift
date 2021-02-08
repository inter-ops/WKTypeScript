//
//  ElementList.swift
//  WKTSwiftUI
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
    
    @State private var darkMode = false
    
    var body: some View {
        List {
            //MARK: Toggle
            Group {
                VStack {
                    ElementHeader(element: elements.toggle)
                    HStack {
                        Toggle(isOn: $toggleState) {
                            Text("Toggle the switch to see what happens in the WebView")
                        }
                        .padding()
                    }
                }
            }
            
            //MARK: Set Label
            Group {
                VStack {
                    ElementHeader(element: elements.setLabel)
                    HStack {
                        TextField("Enter text...", text: $labelText)
                        Spacer()
                        Button(action: {
                            print("Inject label text into TextField")
                        }) {
                            ButtonContent(text: "Submit")
                        }
                    }
                    .padding()
                }
            }
            
            // MARK: Hide Object/Label
            Group {
                VStack {
                    ElementHeader(element: elements.hideLabel)
                    HStack {
                        HStack {
                            Toggle(isOn: $hideLabel) {
                                Text("Display:")
                            }
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                print("Hide object display from WebView")
                            }) {
                                ButtonContent(text: "Submit")
                            }
                        }
                        .padding(.leading, 60)
                    }
                    .padding()
                }
            }
            
            // MARK: Add Numbers
            Group {
                VStack {
                    ElementHeader(element: elements.addNumbers)
                    HStack {
                        TextField("5", text: $firstNumber)
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                        Text("+")
                            .padding()
                        TextField("10", text: $secondNumber)
                            .frame(width: 70)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button(action: {
                            print("Add 2 numbers")
                        }) {
                            ButtonContent(text: "Calculate")
                        }
                    }
                    .padding()
                }
            }
            
            // MARK: Select Device
            Group {
                VStack {
                    ElementHeader(element: elements.selectDevice)
                    HStack {
                        GroupBox {
                            DisclosureGroup("Select Device") {
                                Text("iPhone")
                                Text("iPad")
                                Text("macOS")
                            }
                        }
                    }
                    .padding()
                }
            }
            
            // MARK: Set Mode
            Group {
                VStack {
                    ElementHeader(element: elements.setMode)
                    HStack {
                        Toggle(isOn: $darkMode) {
                            Text("Dark Mode")
                        }
                    }
                    .padding()
                }
            }
            
            
        }
    }
}

struct ButtonContent: View {
    let text: String
    var body: some View {
        Text(text)
            .fontWeight(.medium)
            .padding(10)
            .background(Color.blue)
            .cornerRadius(9)
            .foregroundColor(.white)
    }
}

struct ElementList_Previews: PreviewProvider {
    static var previews: some View {
        ElementList()
            .previewLayout(.fixed(width: 375, height: 1000))
    }
}
