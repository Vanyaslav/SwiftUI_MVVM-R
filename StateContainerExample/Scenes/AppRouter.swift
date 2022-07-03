//
//  AppRouter.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//

import SwiftUI

class AppContext: ObservableObject {
    var data: Decimal = 0 {
        didSet {
            showDetailView = true
        }
    }

    @Published var showDetailView: Bool = false
}

class AppRouter {
    @ObservedObject var context: AppContext

    init(context: AppContext = AppContext()) {
        self.context = context
    }

    var mainView: MainContentView {
        MainContentView(with: .init(with: context),
                        router: self)
    }

    var detailViewNavigation: NavigationLink<EmptyView, DetailContentView> {
        NavigationLink(destination: .init(with: .init(context.data)),
                       isActive: $context.showDetailView)
        { EmptyView() }
    }
}
