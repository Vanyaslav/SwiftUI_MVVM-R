//
//  MainRouter.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//

import SwiftUI

class MainRouter {
    func showMainView() -> WindowGroup <MainContentView> {
        WindowGroup {
            MainContentView(with: MainContentViewModel())
        }
    }
}
