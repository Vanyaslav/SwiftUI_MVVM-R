//
//  TestTests.swift
//  TestTests
//
//  Created by Tomas Baculák on 01/04/2022.
//

import XCTest
import Combine
@testable import StateContainerExample

class StateContainerExampleTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()
    var service: DataService!
    var validation: ValidationService!

    override func setUpWithError() throws {
        service = try? DataService(userDefaults: .test)
        validation = ValidationService()

        service.reset()
    }

    override func tearDownWithError() throws {
        service.reset()
    }

    func testState() throws {
        let router = AppRouter()
        let sut = MainContentViewModel(router: router, dataService: service)
        let defaultValue = MainContentViewModel.defaultValue
        // viewLoaded
        sut.viewLoaded.send()
        XCTAssertEqual(Decimal(sut.outputValue), defaultValue)
        // manualProgress
        sut.manualProgress = 1.000001
        XCTAssertEqual(Decimal(sut.outputValue), 0)
        sut.manualProgress = 0
        XCTAssertEqual(Decimal(sut.outputValue), 0)
        sut.manualProgress = 0.989999
        XCTAssertEqual(Decimal(sut.outputValue), 0.99)
        sut.manualProgress = 0.983999
        XCTAssertEqual(Decimal(sut.outputValue), 0.98)
        sut.manualProgress = 0.999999999999999999999994399394390
        XCTAssertEqual(Decimal(sut.outputValue), 1)
        // progressPressed
        sut.progressPressed.send()
        XCTAssertEqual(Decimal(sut.outputValue), 0)
        sut.progressPressed.send()
        XCTAssertEqual(Decimal(sut.outputValue), 0.1)
    }

    func testDetailViewModel() throws {
        service.reset()
        let sut = DetailContentViewModel(data: Decimal(0.23),
                                         dataService: service,
                                         validateServices: validation)
        // confirm pressed case 1 - a regular number
        sut.updateValue = "0.452111"
        sut.confirmPressed = ()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            do {
                let result = try self.awaitPublisher(self.service.retrieveValue())
                XCTAssertEqual(result, 0.45)
            } catch {}
        }

        // confirm pressed case 2 - not a number
        sut.updateValue = "s"
        sut.confirmPressed = ()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            do {
                let result = try self.awaitPublisher(self.service.retrieveValue())
                XCTAssertEqual(result, 0.45)
            } catch {}
        }
        // no confirm pressed
        sut.updateValue = "0.0000000000000012"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            do {
                let result = try self.awaitPublisher(self.service.retrieveValue())
                XCTAssertEqual(result, 0.45)
            } catch {}
        }
        // confirm pressed
        sut.confirmPressed = ()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            do {
                let result = try self.awaitPublisher(self.service.retrieveValue())
                XCTAssertEqual(result, 0)
            } catch {}
        }
    }
}

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")
        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }
                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
