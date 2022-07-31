//
//  Decimal+Conversions.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 30/07/2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        standardFormat.doubleValue
    }

    var integerValue: Int {
        standardFormat.intValue
    }

    private var standardFormat: NSDecimalNumber {
        var rounded = Decimal()
        var new = self
        NSDecimalRound(&rounded, &new, 2, .plain)
        return NSDecimalNumber(decimal: rounded)
    }
}
