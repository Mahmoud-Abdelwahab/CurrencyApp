//
//  CurrencyBaseResponse.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation

// MARK: - CurrencyBaseResponse
struct CurrencyBaseResponse: Codable {
    let success: Bool?
    let timestamp: Int?
    let historical: Bool?
    let base, date: String?
    let rates: [String: Double]?
}
