//
//  ValidationService.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 31/07/2022.
//

import Foundation

extension ValidationService {
    enum ValidationType {
        case number
    }
}

class ValidationService {
    func validate(_ value: Decimal,
                  as type: ValidationType) -> Bool {
        switch type {
        case .number:
            return !(value.isNaN)
        }
    }
}
