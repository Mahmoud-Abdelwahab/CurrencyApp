//
//  DoExchangeUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation

class DoExchangeUseCase: UseCase {
    private let repository: CurrencyExchangeRepositoryProtocol
    init(repository: CurrencyExchangeRepositoryProtocol = ExchangeCurrencyRepository()){
        self.repository = repository
    }

    func excute(input: (from: String, to: String, amount: Double)) async throws -> String {
        try await repository.doExchange(from: input.from, to: input.to, amount: input.amount)
    }
    

}
