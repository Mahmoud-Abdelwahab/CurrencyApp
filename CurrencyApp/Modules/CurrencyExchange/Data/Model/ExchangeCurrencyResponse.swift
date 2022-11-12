//
//  ExchangeCurrencyResponse.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation


// MARK: - ExchangeCurrencyResponse
struct ExchangeCurrencyResponse: Codable {
    let success: Bool?
    let query: Query?
    let info: Info?
    let date: String?
    let result: Double?
}

// MARK: - Info
struct Info: Codable {
    let timestamp: Int?
    let rate: Double?
}

// MARK: - Query
struct Query: Codable {
    let from, to: String?
    let amount: Int?
}


