//
//  CurrencyExchangeViewModel.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
import RxSwift
import RxRelay

protocol CurrencyExchangeViewModelProtocol {
    var currentState: CurrentState {set get}
    var currencyList: [String] {get}
    var fromSubject  : BehaviorRelay<String> {get}
    var toSubject    : BehaviorRelay<String> {get}
    var amountSubject: BehaviorRelay<Double> {get}
    var screenSubject: PublishSubject<CurrencyExchangeState> {get}
    func doExchange(from: String, to: String, amount: Double)
    func getCurrencySymboleList() -> [String]
    func navigateToCurrencyDetails()
}

class CurrencyExchangeViewModel: CurrencyExchangeViewModelProtocol {
    //MARK: - Variables
    let fromSubject    = BehaviorRelay<String>(value: "USD")
    let toSubject      = BehaviorRelay<String>(value: "EGP")
    let amountSubject  = BehaviorRelay<Double>(value: 1.0)
    let screenSubject  = PublishSubject<CurrencyExchangeState>()
    var currentState = CurrentState.from
    var currencyList =  [String]()
    private let currencyListUseCase: GetCurrencyListUseCaseProtocol
    private let doExchangeUseCase: DoExchangeUseCaseProtocol
    
    init() {
        self.currencyListUseCase = GetCurrencyListUseCase()
        self.doExchangeUseCase = DoExchangeUseCase()
    }
    
    func doExchange(from: String, to: String, amount: Double)  {
        if Helper.validateTwoSymbolesAreDifferent(sybmbole1: from, symbole2: to){
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
            }} else{
                screenSubject.onNext(.showMessage("From and To must not match..."))
            }
    }
    
    func getCurrencySymboleList() -> [String] {
        currencyList = currencyListUseCase.excute()
        return currencyList
    }
    
    func navigateToCurrencyDetails() {
        AppCoordinator.shared.navigateToCurrencyDetails(baseSymbole: fromSubject.value, localSymbole: currencyList)
    }
}
