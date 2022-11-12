//
//  CurrencyExchangeLocalDataSource.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
protocol CurrencyExchangeLocalDataSourceProtocol{
    func getLocalCurrencyList() -> [String]
}

class CurrencyExchangeLocalDataSource: CurrencyExchangeLocalDataSourceProtocol {
    fileprivate  let defaultCurrencySymbolTable = [
        "AUD" ,
        "BGN" ,
        "BRL" ,
        "CAD" ,
        "CHF" ,
        "CNY" ,
        "CZK" ,
        "DKK" ,
        "GBP" ,
        "HKD" ,
        "HRK" ,
        "HUF" ,
        "IDR" ,
        "ILS" ,
        "INR" ,
        "JPY" ,
        "KRW" ,
        "MXN" ,
        "MYR" ,
        "NOK" ,
        "NZD" ,
        "PHP" ,
        "PLN" ,
        "RON" ,
        "RUB" ,
        "SEK" ,
        "SGD" ,
        "THB" ,
        "TRY" ,
        "USD" ,
        "ZAR"
    ]
    
    func getLocalCurrencyList() -> [String] {
        defaultCurrencySymbolTable
    }
    
}



