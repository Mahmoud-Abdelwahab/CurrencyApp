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
    
    //MARK: - Variables
    private let getOtherCurrencyUseCase: GetOtherCurrencyUseCaseProtocol
    private let getHistoricalDataUseCase: GetHistoricalDataUseCaseProtocol
    private (set) var screenState = PublishSubject<DetailsScreenState>()
    private (set) var base: String
    private (set) var localSymbole: [String]
    
    var lastThreeDays: [String]{
        Helper.getLastDates(forLastNDays: 3)
    }
    
    var commonSymboles: String{
        Helper.getSymboleListStringWithoutBase(array: localSymbole, base: base)
    }
    
    //MARK: - Initialization
    init(base: String, localSymbols: [String]) {
        self.getOtherCurrencyUseCase = GetOtherCurrencyUseCase()
        self.getHistoricalDataUseCase = GetHistoricalDataUseCase()
        self.base = base
        self.localSymbole = localSymbols
    }
    
    func fechData()  {
        screenState.onNext(.showLoader)
        getOtherCurrency()
        getHistoryData()
        screenState.onNext(.hideLoader)
    }
    
    func getOtherCurrency(){
        Task {
            do {
                async let otherCurrency =  getOtherCurrencyUseCase.excute(base: base, symbols: commonSymboles)
                try await screenState.onNext(.otherCurrencyData(otherCurrency))
            }catch(let error as APIError){
                screenState.onNext(.showMessage(error.message))
            }
        }
    }
    
    func getHistoryData() {
        Task {
            var currencyList: [CurrencyDomainModel] = []
            try await withThrowingTaskGroup(of: CurrencyDomainModel.self, body: {[weak self] group in
                guard let self else {return}
                for date in lastThreeDays {
                    group.addTask {
                        async let image = self.getHistoricalDataUseCase.excute(date: date, base: self.base, symbols: self.commonSymboles)
                        return try await image
                    }
                }
                for try await model in group {
                    currencyList += [model]
                }
            })
            let  fullHistory =  HistoryCurrecnyListDomainModel(currencyList: currencyList)
            screenState.onNext(.historyData(fullHistory))
        }
    }
    
}


