//
//  String+Conversions.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 31/07/2022.
//

import Foundation

extension String {
    var decimal: Decimal {
        NSDecimalNumber(string: self).decimalValue
    }
}
