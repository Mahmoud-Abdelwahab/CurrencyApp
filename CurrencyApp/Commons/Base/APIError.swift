//
//  APIError.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
// MARK: - API Errors

public enum APIError: Error {
    case decodingError
    case noData
    case with(ErrorDetail)
    case connectionError
    case unknownError

    var message: String {
        switch self {
        case .with(let errorDetail):
            return errorDetail.info
        case .noData:
            return "No Data Found"
        case .decodingError:
            return "Decoding Error ..."
        case .connectionError:
            return "Please check your internet connection"
        case .unknownError:
            return "Unknown error occured"
        }
    }
}

public struct CurrencyLayerError: Error, Decodable {
    let error: ResponseError
}

public struct ErrorDetail: Decodable {
    let code: Int
    let info: String
}
