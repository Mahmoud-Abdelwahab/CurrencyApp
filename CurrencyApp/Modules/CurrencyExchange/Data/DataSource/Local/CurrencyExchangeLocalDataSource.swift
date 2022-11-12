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
        "USD" ,
        "EUR",
        "GBP" ,
        "CAD" ,
        "CHF" ,
        "JPY" ,
        "KWD" ,
        "SAR" ,
        "AED" ,
        "QAR" ,
        "EGP"
    ]
    
    func getLocalCurrencyList() -> [String] {
        defaultCurrencySymbolTable
    }
    
}



