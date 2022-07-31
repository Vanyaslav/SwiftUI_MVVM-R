//
//  MainContentViewModel.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//
import Foundation
import Combine
import SwiftUI

extension MainContentViewModel {
    func navigateToNextView(title: String) -> NavigationLink<Text, DetailContentView> {
        router.showDetailViewNavigation(with: Decimal(outputValue), title: title)
    }
}

class MainContentViewModel: ObservableObject {
    // in
    let viewLoaded: PassthroughSubject<Void, Never> = PassthroughSubject()
    let progressPressed: PassthroughSubject<Void, Never> = PassthroughSubject()

    @Published var manualProgress: Double = 0
    // out
    @Published private (set) var outputValue: Double = 0

    private let router: AppRouter

    init(router: AppRouter, dataService: DataService) {
        self.router = router

        let loaded = viewLoaded
            .map { _ in Event.start(value: dataService.hasAlreadyRun
                                    ? dataService.retrieveValue()
                                    : nil) }
        let pressed = progressPressed
            .map { _ in Event.pressed }
        let progress = $manualProgress
            .dropFirst()
            .map { Event.progress(value: Decimal($0)) }

        Publishers
            .Merge3(loaded, pressed, progress)
// option 2
//           .scan(State()) { state, event in  State.apply(event, for: state) }.print()
// option 1
            .scan(State()) { state, event in state.apply(event) }.print()
            .map {
                let result = $0.value
                dataService.update(result)
                return result.doubleValue
            }
            .assign(to: &$outputValue)
    }
}
