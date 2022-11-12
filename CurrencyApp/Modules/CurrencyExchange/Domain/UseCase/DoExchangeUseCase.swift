//
//  DoExchangeUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation

class DoExchangeUseCase {
    let repository: CurrencyExchangeRepositoryProtocol
    init(repository: CurrencyExchangeRepositoryProtocol = ExchangeCurrencyRepository()){
        self.repository = repository
    }
    
    func excute(from: String, to: String) async throws -> String{
       try await repository.doExchange(from: from, to: to)
    }

}