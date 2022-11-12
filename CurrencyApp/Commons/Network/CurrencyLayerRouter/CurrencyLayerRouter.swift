//
//  CurrencyLayerRouter.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//
import Alamofire

enum CurrencyLayerRouter: URLRequestConvertible {

    case exchange(from: String, to: String, amount: Double)
    
    var method: HTTPMethod {
        switch self {
        case .exchange:
            return .get
        }
    }

    var path: String {
        switch self {
        case .exchange:
            return "fixer/convert"
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .exchange(let from, let to , let amount ):
            return [
                "from": from,
                "to": to,
                "amount": amount
            ]
        }
    }
    
    var header: HTTPHeaders{
        return HTTPHeaders(["apikey": Constants.apiKey])
    }
    

    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.headers = header
        return try URLEncoding.default.encode(request, with: parameters)
    }

}

