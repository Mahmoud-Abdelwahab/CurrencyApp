//
//  CurrencyBaseResponse+Mapper.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation
extension CurrencyBaseResponse {
    func toDomainModel() -> CurrencyDomainModel {
        var currencyList = [String]()
        self.rates?.forEach({ key, value in
            currencyList.append("\(key) : \(value)")
        })
       return  CurrencyDomainModel(base: self.base ?? "",
                            date: self.date ?? "",
                            otherCurrencyList: currencyList)
    }
}
