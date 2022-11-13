//
//  GetOtherCurrencyUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation
protocol GetOtherCurrencyUseCaseProtocol {
    func excute(base: String, symbols: String) async throws -> CurrencyDomainModel
}

class GetOtherCurrencyUseCase: GetOtherCurrencyUseCaseProtocol {
    private let repository: DetailsRepositoryProtocol
    init(repository: DetailsRepositoryProtocol = DetailsRepository()){
        self.repository = repository
    }

    func excute(base: String, symbols: String) async throws -> CurrencyDomainModel {
        try await repository.getOtherCurrency(base: base, symbols: symbols)
    }
}
