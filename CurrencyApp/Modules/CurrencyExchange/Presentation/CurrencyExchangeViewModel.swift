//
//  CurrencyExchangeViewModel.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
import RxSwift
import RxRelay

enum CurrencyExchangeState {
    case hideLodar
    case showLoader
    case result(String)
    case showMessage(String)
}
class CurrencyExchangeViewModel {
    let fromSubject    = BehaviorRelay<String>(value: "USD")
    let toSubject      = BehaviorRelay<String>(value: "EGP")
    let amountSubject  = BehaviorRelay<Double>(value: 1.0)
    var screenSubject  = PublishSubject<CurrencyExchangeState>()
    var currentState = CurrentState.from
    private let currencyListUseCase: GetCurrencyListUseCase
    private let doExchangeUseCase: DoExchangeUseCase
    init( ) {
        self.currencyListUseCase = GetCurrencyListUseCase()
        self.doExchangeUseCase = DoExchangeUseCase()
    }
    
    func doExchange(from: String, to: String, amount: Double)  {
        screenSubject.onNext(.showLoader)
        Task {
            do {
                let result =  try await  doExchangeUseCase.excute(from: from, to: to, amount: amount)
                  screenSubject.onNext(.result(result))
            }catch(let error) {
                print(error)
                screenSubject.onNext(.showMessage(error.localizedDescription))
            }
            screenSubject.onNext(.hideLodar)
        }
       
    }
    
    func getCurrencySymboleList() -> [String] {
        currencyListUseCase.excute()
    }
}
