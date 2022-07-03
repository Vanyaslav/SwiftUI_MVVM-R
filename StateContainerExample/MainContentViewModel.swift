//
//  MainContentViewModel.swift
//  Test
//
//  Created by Tomas Baculák on 17/05/2022.
//
import Foundation
import Combine

protocol MainContentViewModelDependency {
    var router: MainRouter { get }
}

extension MainContentViewModel {
    static var maxValue: Double { 1.0 }
    static var defaultValue: Decimal { 0.4 }
}

extension MainContentViewModel {
// option 1
    struct State {
        var value: Decimal = 0

        func apply(_ action: Event) -> Self {
            var state = self
            switch action {
            case .start:
                state.value = defaultValue
            case .progress(let value):
                state.value = value
            case .pressed:
                state.value += 0.1
            }
            if state.value > Decimal(maxValue) {
                state.value = 0
            }
            return state
        }
    }

// option 2
//    struct State {
//        let value: Decimal
//
//        init(value: Decimal = 0) {
//            self.value = value
//        }
//
//        static func apply(_ action: Event, for state: State) -> Self {
//            switch action {
//            case .start:
//                return State(value: defaultValue)
//            case .progress(let value):
//                return State(value: value)
//            case .pressed:
//                let newState: State
//                let newValue = state.value + 0.1
//                newState = newValue > Decimal(maxValue)
//                ? State(value: 0)
//                : State(value: newValue)
//                return newState
//            }
//        }
//    }
//
    enum Event {
        case start,
             pressed,
             progress(value: Decimal)
    }
}

extension MainContentViewModel {
    struct Dependency: MainContentViewModelDependency {
        let router: MainRouter

        init(with router: MainRouter = MainRouter()) {
            self.router = router
        }
    }
}

class MainContentViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    // in
    let viewLoaded: PassthroughSubject<Void, Never> = PassthroughSubject()
    let buttonPressed: PassthroughSubject<Void, Never> = PassthroughSubject()

    @Published var manualProgress: Double = 0
    // out
    @Published private (set) var outputValue: Double = 0

    init(with dependency: Dependency = Dependency()) {
        let loaded = viewLoaded.map { _ in Event.start }
        let pressed = buttonPressed.map { _ in Event.pressed }
        let progress = $manualProgress.map { Event.progress(value: Decimal($0)) }

        Publishers
            .Merge3(loaded, pressed, progress)
// option 2
//           .scan(State()) { state, event in  State.apply(event, for: state) }
// option 1
            .scan(State()) { state, event in state.apply(event) }
            .map { $0.value.doubleValue }
            .assign(to: \.outputValue, on: self)
            .store(in: &subscriptions)
    }
}

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
