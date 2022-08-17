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
            .flatMap(dataService.retrieveValue)
            .map { dataService.appFirstRun ? nil : $0 }
            .map(Event.start)

        let pressed = progressPressed
            .map { _ in Event.pressed }

        let progress = $manualProgress
            .dropFirst()
            .map { Decimal($0) }
            .map(Event.progress)

        Publishers
            .Merge3(loaded, pressed, progress)
//           .scan(State()) { state, event in  State.apply(event, for: state) }.print() // option 2
            .scan(State()) { state, event in state.apply(event) }.print() // option 1
            .map { $0.value }
            .flatMap(dataService.update)
            .map { $0.doubleValue}
            .assign(to: &$outputValue)
    }
}
