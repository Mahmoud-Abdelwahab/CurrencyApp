//
//  GetHistoricalDataUseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation

class GetHistoricalDataUseCase {
    private let repository: DetailsRepositoryProtocol
    init(repository: DetailsRepositoryProtocol = DetailsRepository()){
        self.repository = repository
    }

    func excute(date: String, base: String, symbols: [String]) async throws -> CurrencyDomainModel {
        try await repository.getHistoicalData(for: date, base: base, symbols: symbols)
    }
   

}
