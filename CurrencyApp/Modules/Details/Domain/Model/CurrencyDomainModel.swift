//
//  CurrencyDomainModel.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation

struct CurrencyDomainModel {
    let base: String
    let date: String
    let otherCurrencyList: [String]
}

struct HistoryCurrecnyListDomainModel {
    let currencyList: [CurrencyDomainModel]
}
