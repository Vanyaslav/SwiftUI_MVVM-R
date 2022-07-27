//
//  AppRouter.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//

import SwiftUI

class AppRouter {
    var mainView: MainContentView {
        .init(with: .init(), router: self)
    }

    func showDetailViewNavigation(with data: Decimal) -> NavigationLink<Text, DetailContentView> {
        .init(destination: .init(with: .init(data)))
        { Text("Show detail !!!") }
    }
}
