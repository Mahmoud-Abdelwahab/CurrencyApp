//
//  CurrencyDetailsViewModelTests.swift
//  CurrencyAppTests
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import XCTest
@testable import CurrencyApp

final class CurrencyDetailsViewModelTests: XCTestCase {

    var sut : CurrencyDetailsViewModel?
    override func setUpWithError() throws {
        sut = CurrencyDetailsViewModel(base: "EGP", localSymbols: ["USD","AUD","CAD","EGP"])
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_Last_Three_Month_Count() throws {
        let givenCount =  3
        let actualCount = sut?.lastThreeDays.count
        XCTAssertEqual(givenCount, actualCount)
    }

    func test_Common_Symbole_Not_Nil() throws {
        let symboleSymbole =  sut?.commonSymboles
      XCTAssertNotNil(symboleSymbole)
    }

}
