//
//  CurrencyExchangeUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation

class CurrencyExchangeUseCase {
    let repository: CurrencyExchangeRepositoryProtocol
    init(repository: CurrencyExchangeRepositoryProtocol = CurrencyExchangeRepository()){
        self.repository = repository
    }
    
    func doExchange(from: String, to: String) async throws -> String{
        "24.5"
    }
    
    func getCurrencyList() -> [String] {
        ["USD","EGP"]
    }
    
}
