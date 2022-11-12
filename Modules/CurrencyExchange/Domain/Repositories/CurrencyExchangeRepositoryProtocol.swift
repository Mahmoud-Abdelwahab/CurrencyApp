//
//  CurrencyExchangeRepositoryProtocol.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
protocol CurrencyExchangeRepositoryProtocol {
    func doExchange(from: String, to: String) async throws -> String
    func getCurrencyList() -> [String]
}
