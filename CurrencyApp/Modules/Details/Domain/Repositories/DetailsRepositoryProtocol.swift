//
//  DetailsRepositoryProtocol.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation
import RxSwift

protocol DetailsRepositoryProtocol {
    func getOtherCurrency(base: String, symbols: [String]) async throws -> CurrencyDomainModel
    func getHistoicalData(for date: String,base: String, symbols: [String]) async throws -> CurrencyDomainModel
}
