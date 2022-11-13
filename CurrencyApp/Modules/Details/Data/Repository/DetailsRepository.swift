//
//  DetailsRepository.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation

class DetailsRepository: DetailsRepositoryProtocol{
    
    private let remoteDataSource: DetailsRemoteDataSourseProtocol
    init(remoteDataSource: DetailsRemoteDataSourseProtocol = DetailsRemoteDataSourse()
    ){
        self.remoteDataSource = remoteDataSource
    }
    
}

extension  DetailsRepository {
    func getOtherCurrency(base: String, symbols: [String]) async throws -> CurrencyDomainModel {
        if Connectivity.isConnectedToInternet {
            return try await remoteDataSource.getOtherCurrency(base: base, symbols: symbols).toDomainModel()
        }else {
            throw APIError.connectionError
        }
    }
    
    func getHistoicalData(for date: String, base: String, symbols: [String]) async throws -> CurrencyDomainModel {
        if Connectivity.isConnectedToInternet {
            return try await remoteDataSource.getHistoicalData(for: date, base: base, symbols: symbols).toDomainModel()
        }else {
            throw APIError.connectionError
        }
    }
    
}
