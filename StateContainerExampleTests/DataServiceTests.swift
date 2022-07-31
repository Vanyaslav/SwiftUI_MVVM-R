//
//  DataServiceTests.swift
//  StateContainerExampleStateContainerExamples
//
//  Created by Tomas Baculák on 31/07/2022.
//

import XCTest
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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service =  try? DataService(userDefaults: .test)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        service.clean()
    }

    func testServicePersistance() throws {
        service.update(30)
        XCTAssertEqual(30, service.retrieveValue())
        service.update(0)
        XCTAssertNotEqual(30, service.retrieveValue())
    }
}
