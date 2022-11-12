//
//  CurrencyExchangeViewModel.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
import RxSwift

class CurrencyExchangeViewModel {
    let fromSubject = BehaviorSubject<String>(value: "USD")
    let toSubject   = BehaviorSubject<String>(value: "EGP")
    let amount      = BehaviorSubject<Double>(value: 1.0)
    
    let currencyListUseCase: DoExchangeUseCase
    init(currencyListUseCase: any UseCase = DoExchangeUseCase() ) {
        self.currencyListUseCase = currencyListUseCase as! DoExchangeUseCase
    }
    
    func doExchange(from: String, to: String, amount: Double) async{
        do {
          let result =  try await  currencyListUseCase.excute(input: (from: from, to: to, amount: amount))
            print(result)
        }catch(let error) {
            print(error)
        }
    
    }
}
