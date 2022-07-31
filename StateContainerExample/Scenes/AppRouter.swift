//
//  AppRouter.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//

import SwiftUI

extension AppRouter {
    func showMainView() -> MainContentView {
        .init(with: .init(router: self, dataService: dataService))
    }

    func showDetailViewNavigation(with data: Decimal, title: String) -> NavigationLink<Text, DetailContentView> {
        .init(destination: .init(with: .init(data: data,
                                             dataService: dataService,
                                             validateServices: validationService)))
        { Text(title) }
    }
}

class AppRouter {
    private let dataService: DataService
    private let validationService: ValidationService

    init(
        dataService: DataService = DataService(),
        validationService: ValidationService = ValidationService()
    ) {
        self.dataService = dataService
        self.validationService = validationService
        defaultUIObject()
    }
}

extension AppRouter {
    private func defaultUIObject() {
        UITextView.appearance().backgroundColor = .clear
    }
}
