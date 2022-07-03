//
//  TestTests.swift
//  TestTests
//
//  Created by Tomas Baculák on 01/04/2022.
//

import XCTest
@testable import StateContainerExample

class StateContainerExampleTests: XCTestCase {
    func testState() throws {
        let router = MainRouter()
        let viewModel = MainContentViewModel(with: router)
        viewModel.viewLoaded.send()
        XCTAssertEqual(Decimal(viewModel.outputValue), MainContentViewModel.defaultValue)
        viewModel.manualProgress = 1.000001
        viewModel.showDetailPressed = ()
        XCTAssertEqual(router.context.data, 0)
        viewModel.manualProgress = 0.99999999
        viewModel.showDetailPressed = ()
        XCTAssertEqual(router.context.data, 0.99999999)
    }

    func testNavigation() throws {
        let router = MainRouter()
        let viewModel = MainContentViewModel(with: router)
        XCTAssertEqual(router.context.showDetailView, false)
        viewModel.showDetailPressed = ()
        XCTAssertEqual(router.context.showDetailView, true)
    }
}
