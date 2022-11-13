//
//  CurrencyExchangeViewModelTests.swift
//  CurrencyAppTests
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import XCTest
@testable import CurrencyApp

final class CurrencyExchangeViewModelTests: XCTestCase {

    var sut: CurrencyExchangeViewModelProtocol?
    override func setUpWithError() throws {
        sut =  CurrencyExchangeViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCurrencyState() throws {
        //Given
        let state = CurrentState.from
        //When
        let actual = sut?.currentState
        //Then
        XCTAssertEqual(state, actual)
    }

    func testCurrencySymboleList_is_equal_11() throws {
      let excpected = 11
      let actual = sut?.getCurrencySymboleList().count
     XCTAssertEqual(excpected, actual,"Currency Symbole Not equal 11")
    }
    

}
