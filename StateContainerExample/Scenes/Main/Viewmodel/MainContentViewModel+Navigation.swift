//
//  MainContentViewModel+Navigation.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 31/07/2022.
//

import SwiftUI

extension MainContentViewModel {
    func navigateToNextView(title: String) -> NavigationLink<Text, DetailContentView> {
        router.showDetailViewNavigation(with: Decimal(outputValue), title: title)
    }
}
