//
//  CurrencyExchangeRepositoryProtocol.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
import RxSwift

protocol CurrencyExchangeRepositoryProtocol {
    func doExchange(from: String, to: String, amount: Double) async throws -> String
    func getCurrencyList() -> [String]
}
