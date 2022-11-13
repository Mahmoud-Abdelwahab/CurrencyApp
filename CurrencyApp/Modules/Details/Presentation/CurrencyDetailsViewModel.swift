//
//  CurrencyDetailsViewModel.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation
import RxSwift

enum DetailsScreenState {
    case otherCurrencyData(CurrencyDomainModel)
    case historyData(HistoryCurrecnyListDomainModel)
    case showLoader
    case hideLoader
    case showMessage(String)
}

class CurrencyDetailsViewModel {
    
    private let getOtherCurrencyUseCase: GetOtherCurrencyUseCase
    private let getHistoricalDataUseCase: GetHistoricalDataUseCase
    private (set) var screenState = PublishSubject<DetailsScreenState>()
    private (set) var base: String
    private (set) var localSymbole: [String]
    
    var lastThreeDays: [String]{
        Helper.getLastDates(forLastNDays: 3)
    }
    
    var commonSymboles: String{
        Helper.getSymboleListStringWithoutBase(array: localSymbole, base: base)
    }
    
    init(base: String, localSymbols: [String]) {
        self.getOtherCurrencyUseCase = GetOtherCurrencyUseCase()
        self.getHistoricalDataUseCase = GetHistoricalDataUseCase()
        self.base = base
        self.localSymbole = localSymbols
    }
    
    func fechData()  {
        screenState.onNext(.showLoader)
        Task {
            do {
                async let otherCurrency =  getOtherCurrencyUseCase.excute(base: base, symbols: commonSymboles)
                async let history1      =  getHistoricalDataUseCase.excute(date: lastThreeDays[0], base: base, symbols: commonSymboles)
                async let history2      = getHistoricalDataUseCase.excute(date:  lastThreeDays[1], base: base, symbols: commonSymboles)
                async let history3      =  getHistoricalDataUseCase.excute(date: lastThreeDays[2], base: base, symbols: commonSymboles)
                try await screenState.onNext(.otherCurrencyData(otherCurrency))
                let  fullHistory = try await HistoryCurrecnyListDomainModel(
                    currencyList: [
                    history1 , history2, history3
                ])
                screenState.onNext(.historyData(fullHistory))
            }catch(let error){
                screenState.onNext(.showMessage(error.localizedDescription))
            }
            screenState.onNext(.hideLoader)
        }
    }
  
}


