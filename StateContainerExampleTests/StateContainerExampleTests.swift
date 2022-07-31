//
//  TestTests.swift
//  TestTests
//
//  Created by Tomas Baculák on 01/04/2022.
//

import XCTest
@testable import StateContainerExample

class StateContainerExampleTests: XCTestCase {
    var service: DataService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service =  try? DataService(userDefaults: .test)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        service.clean()
    }

    func testState() throws {
        service.clean()
        let router = AppRouter()
        let viewModel = MainContentViewModel(router: router, dataService: service)
        let defaultValue = MainContentViewModel.defaultValue
        viewModel.viewLoaded.send()
        XCTAssertEqual(Decimal(viewModel.outputValue), defaultValue)
        viewModel.manualProgress = 1.000001
        XCTAssertEqual(Decimal(viewModel.outputValue), 0)
        viewModel.manualProgress = 0
        XCTAssertEqual(service.retrieveValue(), 0)
        viewModel.manualProgress = 0.989999
        XCTAssertEqual(service.retrieveValue(), 0.99)
        viewModel.manualProgress = 0.983999
        XCTAssertEqual(service.retrieveValue(), 0.98)
        viewModel.manualProgress = 0.999999999999999999999994399394390
        XCTAssertEqual(service.retrieveValue(), 1)
    }

    func testDetailViewModel() {
        service.clean()
        let model = DetailContentViewModel(data: 0.23,
                                           dataService: service,
                                           validateServices: ValidationService())
        model.updateValue = "0.452111"
        model.confirmPressed = ()
        XCTAssertEqual(service.retrieveValue(), 0.45)
        model.updateValue = "s"
        XCTAssertEqual(service.retrieveValue(), 0.45)
        model.updateValue = "0.0000000000000012"
        XCTAssertEqual(service.retrieveValue(), 0.45)
        model.confirmPressed = ()
        XCTAssertEqual(service.retrieveValue(), 0)
    }
}
