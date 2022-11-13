//
//  CurrencyLayerRouter.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//
import Alamofire

enum CurrencyLayerRouter: URLRequestConvertible {

    case exchange(from: String, to: String, amount: Double)
    case getOtherCurrency(base: String, symbols: [String])
    case getHistoicalData( date: String, base: String, symbols: [String])
    var method: HTTPMethod {
        switch self {
        case .exchange,.getOtherCurrency,.getHistoicalData:
            return .get
        }
    }

    var path: String {
        switch self {
        case .exchange:
            return "fixer/convert"
        case .getOtherCurrency:
            return "fixer/latest"
        case .getHistoicalData(let date, _, _):
            return "fixer/\(date)"
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
            
        case .getOtherCurrency(let base, let symbols):
            return [
                "base": base,
                "symbols": symbols
            ]
        case .getHistoicalData(_,let base,let symbols):
              return [
                "base": base,
                "symbols": symbols
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

