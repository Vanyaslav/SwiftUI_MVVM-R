//
//  AppRouter+Dependency.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 31/07/2022.
//

import Foundation

protocol AppRouterDependency {
    var dataService: DataService { get }
    var validationService: ValidationService { get }
}

extension AppRouter {
    struct DependencyContainer: AppRouterDependency {
        let dataService: DataService
        let validationService: ValidationService

        init(
            dataService: DataService = .init(),
            validationService: ValidationService = .init()
        ) {
            self.dataService = dataService
            self.validationService = validationService
        }
    }
}
