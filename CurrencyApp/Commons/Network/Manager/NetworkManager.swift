//
//  NetworkManager.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Alamofire

class NetworkManager  {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func sendRequest<T>(urlRequest: Alamofire.URLRequestConvertible) async throws -> T  where T: Decodable {
        try await withCheckedThrowingContinuation { continuation in
            let request = AF.request(urlRequest)
            request.responseDecodable(of: T.self, completionHandler: { response in
                guard let data = response.data else {
                    continuation.resume(throwing: APIError.noData)
                    return
                }
                do {
                    if let model = try? JSONDecoder().decode(T.self, from: data) {
                        continuation.resume(returning: model)
                    } else {
                        let currencyLayerError = try JSONDecoder().decode(ResponseError.self, from: data)
                        continuation.resume(throwing: APIError.with(ErrorDetail(code: currencyLayerError.code ?? 0, info: currencyLayerError.info ?? "")))
                    }
                } catch {
                    continuation.resume(throwing: APIError.decodingError)
                }
            })
        }
    }
    
}
