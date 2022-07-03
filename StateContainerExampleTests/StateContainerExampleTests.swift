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
        let context = AppContext()
        let viewModel = MainContentViewModel(with: context)
        let defaultValue = MainContentViewModel.defaultValue
        viewModel.viewLoaded.send()
        XCTAssertEqual(Decimal(viewModel.outputValue), defaultValue)
        viewModel.showDetailPressed = ()
        XCTAssertEqual(context.data, defaultValue)
        viewModel.manualProgress = 1.000001
        XCTAssertEqual(Decimal(viewModel.outputValue), 0)
        viewModel.showDetailPressed = ()
        XCTAssertEqual(context.data, 0)
        viewModel.manualProgress = 0.99999999
        XCTAssertEqual(Decimal(viewModel.outputValue), 0.99999999)
        viewModel.showDetailPressed = ()
        XCTAssertEqual(context.data, 0.99999999)
    }

    func testNavigation() throws {
        let context = AppContext()
        let viewModel = MainContentViewModel(with: context)
        XCTAssertEqual(context.showDetailView, false)
        viewModel.showDetailPressed = ()
        XCTAssertEqual(context.showDetailView, true)
    }
}
