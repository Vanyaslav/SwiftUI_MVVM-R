//
//  MainContentViewModel+Event.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 31/07/2022.
//

import Foundation

extension MainContentViewModel {
    enum Event {
        case start(value: Decimal),
             pressed,
             progress(value: Decimal)
    }
}
