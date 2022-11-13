//
//  DoExchangeUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation

protocol DoExchangeUseCaseProtocol {
    func excute(from: String, to: String, amount: Double) async throws -> String
}

class DoExchangeUseCase: DoExchangeUseCaseProtocol {
    private let repository: CurrencyExchangeRepositoryProtocol
    init(repository: CurrencyExchangeRepositoryProtocol = ExchangeCurrencyRepository()){
        self.repository = repository
    }

    func excute(from: String, to: String, amount: Double) async throws -> String {
        try await repository.doExchange(from: from, to: to, amount: amount)
    }
    

}
