//
//  ExchangeCurrencyRepository.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation

class ExchangeCurrencyRepository: CurrencyExchangeRepositoryProtocol{
    
    let localDataSource: CurrencyExchangeLocalDataSourceProtocol
    let remoteDataSource: CurrencyExchangeRemoteDataSourceProtocol
    init(localDataSource: CurrencyExchangeLocalDataSourceProtocol = CurrencyExchangeLocalDataSource(),
         remoteDataSource: CurrencyExchangeRemoteDataSourceProtocol = CurrencyExchangeRemoteDataSource()
    ){
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
}

extension  ExchangeCurrencyRepository {
    func doExchange(from: String, to: String) async throws -> String {
        
       try await remoteDataSource.doExchange(from: from, to: to)
    }
    
    func getCurrencyList() -> [String] {
        localDataSource.getLocalCurrencyList()
    }

}
