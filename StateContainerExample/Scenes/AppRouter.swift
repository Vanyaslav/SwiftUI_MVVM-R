//
//  AppRouter.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//

import SwiftUI

extension AppRouter {
    func showMainView() -> MainContentView {
        .init(with: .init(router: self, dataService: dependency.dataService))
    }

    func showDetailViewNavigation(with data: Decimal, title: String) -> NavigationLink<Text, DetailContentView> {
        .init(destination: .init(with: .init(data: data,
                                             dataService: dependency.dataService,
                                             validateServices: dependency.validationService)))
        { Text(title) }
    }
}

class AppRouter {
    private let dependency: DependencyContainer

    init(dependency: DependencyContainer = DependencyContainer()) {
        self.dependency = dependency
        defaultUIObject()
    }
}

extension AppRouter {
    private func defaultUIObject() {
        UITextView.appearance().backgroundColor = .clear
    }
}
