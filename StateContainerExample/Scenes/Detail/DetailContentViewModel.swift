//
//  DetailContentViewModel.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 03/07/2022.
//

import Foundation

struct DetailContentViewModel {
    let data: String

    init(_ data: Decimal) {
        self.data = "\(data)"
    }
}
