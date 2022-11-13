//
//  DetailsRemoteDataSourse.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation

protocol DetailsRemoteDataSourseProtocol{
    func getOtherCurrency(base: String, symbols: [String]) async throws -> CurrencyBaseResponse
    func getHistoicalData(for date: String,base: String, symbols: [String]) async throws -> CurrencyBaseResponse
}

class DetailsRemoteDataSourse: DetailsRemoteDataSourseProtocol {
    func getOtherCurrency(base: String, symbols: [String]) async throws -> CurrencyBaseResponse {
        try await NetworkManager.shared.sendRequest(urlRequest: CurrencyLayerRouter.getOtherCurrency(base: base, symbols: symbols))
    }
    
    func getHistoicalData(for date: String, base: String, symbols: [String]) async throws -> CurrencyBaseResponse {
        try await NetworkManager.shared.sendRequest(urlRequest: CurrencyLayerRouter.getHistoicalData(date: date, base: base, symbols: symbols))
    }
    
 
}

