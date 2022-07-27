//
//  AppRouter.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//

import SwiftUI

class AppContext {
    var data: Decimal = 0
}

class AppRouter {
    private var context: AppContext

    init(context: AppContext = AppContext()) {
        self.context = context
    }

    var mainView: MainContentView {
        MainContentView(with: .init(with: context), router: self)
    }

    var newDetailViewNavigation: NavigationLink<Text, DetailContentView>? {
        NavigationLink(destination: DetailContentView(with: DetailContentViewModel(context.data)))
        {  Text("Show detail !!!") }
    }
}
