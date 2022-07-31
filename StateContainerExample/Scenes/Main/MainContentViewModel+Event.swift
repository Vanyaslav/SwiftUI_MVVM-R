//
//  MainContentViewModel+Event.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 31/07/2022.
//

import Foundation

extension MainContentViewModel {
    static var maxValue: Double { 1.0 }
    static var defaultValue: Decimal { 0.4 }
}

extension MainContentViewModel {
    enum Event {
        case start(value: Decimal?),
             pressed,
             progress(value: Decimal)
    }
}
