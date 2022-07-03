//
//  MainRouter.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//

import SwiftUI

class AppContext: ObservableObject {
    @Published var data: Decimal = 0 {
        didSet {
            showDetailView = true
        }
    }

    @Published var showDetailView: Bool = false
}

class MainRouter {
    @ObservedObject var context: AppContext

    init(context: AppContext = AppContext()) {
        self.context = context
    }

    var detailView: NavigationLink<EmptyView, DetailContentView> {
        NavigationLink(destination: DetailContentView(with: DetailContentViewModel(context.data)),
                       isActive: $context.showDetailView)
        { EmptyView() }
    }
}
