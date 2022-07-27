//
//  AppRouter.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//

import SwiftUI

extension AppRouter {
    class FlowData {
        var data: Decimal = 0
    }
}

class AppRouter {
    private var content: FlowData

    init(context: FlowData = FlowData()) {
        self.content = context
    }

    var mainView: MainContentView {
        MainContentView(with: .init(with: content), router: self)
    }

    var newDetailViewNavigation: NavigationLink<Text, DetailContentView>? {
        NavigationLink(destination: DetailContentView(with: DetailContentViewModel(content.data)))
        {  Text("Show detail !!!") }
    }
}
