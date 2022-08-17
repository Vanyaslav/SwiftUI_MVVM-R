//
//  DataService.swift
//  StateContainerExample
//
//  Created by Tomas Baculák on 27/07/2022.
//

import Foundation

extension String {
    fileprivate static let storedValue: Self = "storedValue"
    fileprivate static let firstRun: Self = "firstRun"
}

protocol DataServiceProtocol {
    func update(_ value: Decimal)
    func retrieveValue() -> Decimal
    func clean()
}

class DataService: DataServiceProtocol {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func update(_ value: Decimal) {
        userDefaults
            .set((value * 100).integerValue,
                 forKey: .storedValue)
    }

    func retrieveValue() -> Decimal {
        Decimal(Double(userDefaults.integer(forKey: .storedValue)) / 100)
    }

    func clean() {
        userDefaults
            .set(false, forKey: .firstRun)
    }
}

extension DataService {
    var appFirstRun: Bool {
        let isFirstRun = userDefaults.bool(forKey: .firstRun)
        userDefaults.set(false, forKey: .firstRun)
        return isFirstRun
    }
}
