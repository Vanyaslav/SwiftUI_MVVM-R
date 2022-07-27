//
//  MainContentViewModel.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//
import Foundation
import Combine

class MainContentViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    // in
    let viewLoaded: PassthroughSubject<Void, Never> = PassthroughSubject()
    let makeProgressPressed: PassthroughSubject<Void, Never> = PassthroughSubject()

    @Published var manualProgress: Double = 0
    // out
    @Published private (set) var outputValue: Double = 0

    init(with context: AppContext) {
        let loaded = viewLoaded.map { _ in Event.start }
        let pressed = makeProgressPressed.map { _ in Event.pressed }
        let progress = $manualProgress.map { Event.progress(value: Decimal($0)) }

        Publishers
            .Merge3(loaded, pressed, progress)
// option 2
//           .scan(State()) { state, event in  State.apply(event, for: state) }
// option 1
            .scan(State()) { state, event in state.apply(event) }
            .map { $0.value.doubleValue }
            .assign(to: &$outputValue)

        $outputValue
            .dropFirst()
            .map { Decimal($0) }
            .assign(to: \.data, on: context)
            .store(in: &subscriptions)
    }
}

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
