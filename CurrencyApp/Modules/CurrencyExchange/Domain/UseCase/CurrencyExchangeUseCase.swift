//
//  CurrencyExchangeUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation

class CurrencyExchangeUseCase {
    let repository: CurrencyExchangeRepositoryProtocol
    init(repository: CurrencyExchangeRepositoryProtocol = ExchangeCurrencyRepository()){
        self.repository = repository
    }
    
    func doExchange(from: String, to: String) async throws -> String{
       try await repository.doExchange(from: from, to: to)
    }
    
    func getCurrencyList() -> [String] {
        repository.getCurrencyList()
    }
    
}
