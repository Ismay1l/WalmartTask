//
//  Walmart_TaskTest.swift
//  Walmart_TaskTest
//
//  Created by Ismayil Ismayilov on 4/19/24.
//

import XCTest
@testable import Walmart_Task

final class Walmart_TaskTest: XCTestCase {

    var viewModel: SearchViewModel!
    var dependencies: Dependencies!

    override func setUp() {
        super.setUp()
        dependencies = Dependencies(service: MockCountryService())
        viewModel = SearchViewModel(countryService: dependencies)
    }

    override func tearDown() {
        viewModel = nil
        dependencies = nil
        super.tearDown()
    }

    func testFetchcountryList() throws {
        let expectation = self.expectation(description: "Fetch country list")
        viewModel.fetchCountryList { country in
            XCTAssertEqual(country.first?.name, "Kabul")
            XCTAssertEqual(country.first?.code, "AF")
        } errorMessage: { message in
            XCTFail(message)
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 5.0)
    }
}
