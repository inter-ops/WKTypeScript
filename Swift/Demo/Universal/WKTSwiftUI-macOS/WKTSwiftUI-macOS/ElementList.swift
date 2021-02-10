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
                        .onChange(of: toggleState) { value in
                            Builder.set(.toggle)
                        }
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
                            Builder.set(.setLabel, value: labelText)
                        }) {
                            Text("Update Label")
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
                                InlineCode(text: " display: none;")
                            }
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                Builder.set(.hideLabel, value: hideLabel)
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
                        InlineTextField(digit: "5", number: $firstNumber)
                        Text("+")
                            .padding()
                        InlineTextField(digit: "10", number: $secondNumber)
                        
                        Spacer()
                        
                        Button(action: {
                            Builder.set(.addNumbers, value: [firstNumber, secondNumber])
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
                        .onChange(of: selectedDevice, perform: { _ in
                            Builder.set(.selectDevice, value: selectedDevice)
                        })
                    }
                    .padding()
                    
                    HStack {
                        Text("Device:")
                        InlineCode(text: selectedDevice)
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
                        .onChange(of: selectedMode, perform: { _ in
                            Builder.set(.setMode, value: selectedMode)
                        })
                    }
                    .padding()
                    
                    HStack {
                        Text("Current Mode:")
                        InlineCode(text: selectedMode)
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
        .padding(.vertical, 8)
        .padding(.horizontal, 14)
    }
}

struct InlineCode: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(.body, design: .monospaced))
            .font(.system(size: 14))
            .fontWeight(.regular)
    }
}

struct InlineTextField: View {
    let digit: String
    //@State var number: String
    @State var number: Binding<String>
    
    var body: some View {
        TextField(digit, text: number)
            .frame(width: 70)
            .multilineTextAlignment(.center)
    }
}


struct ElementList_Previews: PreviewProvider {
    static var previews: some View {
        ElementList()
            .previewLayout(.fixed(width: 375, height: 1100))
    }
}
