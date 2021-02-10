//
//  ElementList.swift
//  Demo (macOS)
//  Inter-Ops/WKTypeScript
//
//  Created by Justin Bush on 2021-02-05.
//

import SwiftUI

//class ToggleCode: ObservableObject {
//    @Published var mode: String = "setMode(.light)"
//}

let elements = DemoElements.self
struct ElementList: View {
    @State private var toggleState = false
    @State private var labelText: String = ""
    @State private var hideObject = false
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    
    @State private var selectedDevice = "iPhone"
    var devices = ["iPhone", "iPad", "macOS"]
    
    @State private var selectedMode = "Light"
    var modes = ["Light", "Dark"]
    
    @State var modeCode = "setMode(.light)"
    
    var body: some View {
        List {
            
            Group {
                VStack {
                    ElementHeader(element: elements.toggleMode)
                    ElementDescription(element: elements.toggleMode)
                    
                    HStack {
                        Picker(selection: $selectedMode, label: Text("")) {
                            Text("Light").tag("Light")
                            Text("Dark").tag("Dark")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectedMode) { _ in
                            Builder.set(.setMode, value: selectedMode)
                        }
                    }
                    .padding()
                }
                Divider()
            }
            
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
                    ElementHeader(element: elements.hideObject)
                    HStack {
                        HStack {
                            Toggle(isOn: $hideObject) {
                                InlineCode(text: " display: none;")
                            }
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                Builder.set(.hideObject, value: hideObject)
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
                            Text("iPhone").tag("iPhone")
                            Text("iPad").tag("iPad")
                            Text("macOS").tag("macOS")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectedDevice) { _ in
                            Builder.set(.selectDevice, value: selectedDevice)
                        }
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
                            Text("Light").tag("Light")
                            Text("Dark").tag("Dark")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectedMode) { _ in
                            Builder.set(.setMode, value: selectedMode)
                        }
                    }
                    .padding()
                    
                    HStack {
                        Text("Current Mode:")
                        InlineCode(text: selectedMode)
                    }
                    
                }
            }
            
            
        }
        .listStyle(SidebarListStyle())
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
        .lineLimit(nil)
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
