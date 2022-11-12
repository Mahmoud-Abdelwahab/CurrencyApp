//
//  GetCurrencyListUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation

class GetCurrencyListUseCase {
    let repository: CurrencyExchangeRepositoryProtocol
    init(repository: CurrencyExchangeRepositoryProtocol = ExchangeCurrencyRepository()){
        self.repository = repository
    }
    
    func excute() -> [String] {
        repository.getCurrencyList()
    }
    
}
