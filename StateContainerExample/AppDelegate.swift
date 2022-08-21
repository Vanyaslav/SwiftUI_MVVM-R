//
//  AppDelegate.swift
//  Test
//
//  Created by Tomas Baculák on 01/04/2022.
//

import SwiftUI

@main
struct SwiftUIExampleApp: App {
    var body: some Scene {
        WindowGroup {
            AppRouter()
                .showMainView()
        }
    }
}
