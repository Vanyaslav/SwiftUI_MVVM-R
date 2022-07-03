//
//  MainContentViewModel+State.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 03/07/2022.
//

import Foundation

extension MainContentViewModel {
    static var maxValue: Double { 1.0 }
    static var defaultValue: Decimal { 0.4 }
}

extension MainContentViewModel {
    enum Event {
        case start,
             pressed,
             progress(value: Decimal)
    }
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
}
