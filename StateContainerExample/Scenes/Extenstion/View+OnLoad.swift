//
//  View+OnLoad.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 27/07/2022.
//

import SwiftUI

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
