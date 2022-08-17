//
//  DataServiceTests.swift
//  StateContainerExampleStateContainerExamples
//
//  Created by Tomas Baculák on 31/07/2022.
//

import XCTest
import Combine
@testable import StateContainerExample

extension UserDefaults {
    public static var test: UserDefaults {
        get throws {
            try XCTUnwrap(UserDefaults(suiteName: "Test"))
        }
    }
}

class DataServiceTests: XCTestCase {
    var service: DataService!

    override func setUpWithError() throws {
        service =  try? DataService(userDefaults: .test)
    }

    override func tearDownWithError() throws {
        service.clean()
    }

    func testServicePersistance() throws {
        _ = try awaitPublisher(service.update(30))
        let sut1 = try awaitPublisher(service.retrieveValue())
        XCTAssertEqual(sut1, 30)
        _ = try awaitPublisher(service.update(0))
        let sut2 = try awaitPublisher(service.retrieveValue())
        XCTAssertEqual(sut2, 0)
    }
}
