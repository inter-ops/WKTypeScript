//
//  ElementListHostingController.swift
//  Example
//
//  Created by Justin Bush on 2021-02-07.
//

import Foundation
import SwiftUI

class ElementListHostingController: NSHostingController<ElementList> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ElementList())
    }
}
