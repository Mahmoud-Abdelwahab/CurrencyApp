//
//  ExchangeCurrencyRepository.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation

class ExchangeCurrencyRepository: CurrencyExchangeRepositoryProtocol{
    
    private let localDataSource: CurrencyExchangeLocalDataSourceProtocol
    private let remoteDataSource: CurrencyExchangeRemoteDataSourceProtocol
    init(localDataSource: CurrencyExchangeLocalDataSourceProtocol = CurrencyExchangeLocalDataSource(),
         remoteDataSource: CurrencyExchangeRemoteDataSourceProtocol = CurrencyExchangeRemoteDataSource()
    ){
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
}

extension  ExchangeCurrencyRepository {
    func doExchange(from: String, to: String, amount: Double) async throws -> String {
        if Connectivity.isConnectedToInternet {
            return try await remoteDataSource.doExchange(from: from, to: to, amount: amount).result?.description  ?? "0.0"
        }else {
            throw APIError.connectionError
        }
    }
    
    func getCurrencyList() -> [String] {
        localDataSource.getLocalCurrencyList()
    }

}
