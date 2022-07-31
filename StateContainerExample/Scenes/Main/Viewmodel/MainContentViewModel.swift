//
//  MainContentViewModel.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//
import Foundation
import Combine
import SwiftUI

class MainContentViewModel: ObservableObject {
    // in
    let viewLoaded: PassthroughSubject<Void, Never> = PassthroughSubject()
    let progressPressed: PassthroughSubject<Void, Never> = PassthroughSubject()

    @Published var manualProgress: Double = 0
    // out
    @Published private (set) var outputValue: Double = 0

    private (set) var router: AppRouter

    init(
        router: AppRouter,
        dataService: DataService
    ) {
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
//           .scan(State()) { state, event in  State.apply(event, for: state) }.print() // option 2
            .scan(State()) { state, event in state.apply(event) }.print() // option 1
            .map {
                let result = $0.value
                dataService.update(result)
                return result.doubleValue
            }
            .assign(to: &$outputValue)
    }
}
