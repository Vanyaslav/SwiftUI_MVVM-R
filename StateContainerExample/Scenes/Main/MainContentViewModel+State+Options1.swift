//
//  MainContentViewModel+State.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 03/07/2022.
//

import Foundation
// option 1
extension MainContentViewModel {
    struct State {
        var value: Decimal = 0

        func apply(_ action: Event) -> Self {
            var state = self
            switch action {
            case .start(value: .none):
                state.value = defaultValue
            case .start(let value?):
                state.value = value
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
}
