//
//  GetCurrencyListUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
protocol GetCurrencyListUseCaseProtocol {
    func excute() -> [String]
}

class GetCurrencyListUseCase: GetCurrencyListUseCaseProtocol {
    private let repository: CurrencyExchangeRepositoryProtocol
    init(repository: CurrencyExchangeRepositoryProtocol = ExchangeCurrencyRepository()){
        self.repository = repository
    }
    
    func excute() -> [String] {
        repository.getCurrencyList()
    }
    
}
