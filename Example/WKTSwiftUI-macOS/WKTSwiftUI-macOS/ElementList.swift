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
    @State private var hideLabel = false
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    
    @State private var selectedDevice = "iPhone"
    var devices = ["iPhone", "iPad", "macOS"]
    
    @State private var selectedMode = "Light"
    var modes = ["Light", "Dark"]
    
    var body: some View {
        List {
            
            // MARK: Toggle
            Group {
                VStack {
                    ElementHeader(element: elements.toggle)
                    ElementDescription(element: elements.toggle)
                    
                    HStack {
                        Text("Toggle to see what happens:")
                        
                        Toggle(isOn: $toggleState) {
                            Text("")
                        }
                        .padding()
                    }
                }
                
                Divider()
            }
            
            
            
            // MARK: Set Label
            Group {
                VStack {
                    ElementHeader(element: elements.setLabel)
                    ElementDescription(element: elements.setLabel)
                    
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
                
                Divider()
            }
            
            
            
            // MARK: Hide Object/Label
            Group {
                VStack {
                    ElementHeader(element: elements.hideLabel)
                    HStack {
                        HStack {
                            Toggle(isOn: $hideLabel) {
                                Text(" display: none;")
                                    .font(.system(.body, design: .monospaced))
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
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
                
                Divider()
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
                            print("Add 2 numbers and inject into WebView.")
                        }) {
                            Text("Calculate")
                        }
                    }
                    .padding()
                }
                
                Divider()
            }
            
            
            
            // MARK: Select Device
            Group {
                VStack {
                    ElementHeader(element: elements.selectDevice)
                    ElementDescription(element: elements.selectDevice)
                    
                    HStack {
                        
                        Picker(selection: $selectedDevice, label: Text("")) {
                            ForEach(devices, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    HStack {
                        Text("Selected:")
                        Text(selectedDevice)
                            .font(.system(.body, design: .monospaced))
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                        //Text("Selected: \(selectedDevice)")
                    }
                    
                }
                
                Divider()
            }
            
            
            
            // MARK: Set Mode
            Group {
                VStack {
                    ElementHeader(element: elements.setMode)
                    ElementDescription(element: elements.setMode)
                    
                    HStack {
                        
                        Picker(selection: $selectedMode, label: Text("")) {
                            ForEach(modes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    
                    HStack {
                        Text("Current Mode:")
                        Text(selectedMode)
                            .font(.system(.body, design: .monospaced))
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                        //Text("Selected: \(selectedDevice)")
                    }
                    
                }
            }
            
            
        }
    }
}


struct ElementDescription: View {
    let element: DemoElements
    
    var body: some View {
        HStack {
            Text(element.description)
                
            Spacer()
        }
        .multilineTextAlignment(.leading)
        .padding(.vertical, 4)
        .padding(.horizontal, 14)
    }
}


struct ElementList_Previews: PreviewProvider {
    static var previews: some View {
        ElementList()
            .previewLayout(.fixed(width: 375, height: 1100))
    }
}
