//
//  CurrencyDetailsViewModel.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation

class CurrencyDetailsViewModel {
    
    private let getOtherCurrencyUseCase: GetOtherCurrencyUseCase
    private let getHistoricalDataUseCase: GetHistoricalDataUseCase
    private (set) var base: String
    private (set) var localSymbole: [String]
    var lastThreeDays: [String]{
        Helper.getLastDates(forLastNDays: 3)
    }
    init(base: String, localSymbols: [String]) {
        self.getOtherCurrencyUseCase = GetOtherCurrencyUseCase()
        self.getHistoricalDataUseCase = GetHistoricalDataUseCase()
        self.base = base
        self.localSymbole = localSymbols
    }
    
    func getOtherCurrencyRate(base: String, symbols: String) {
        Task{
            do {
                let result = try await getOtherCurrencyUseCase.excute(base: base, symbols: symbols)
             
            }catch(let error) {
                print(error)
            }
        }
    }
    
    func getHistoricalDataUseCase(date: String, base: String, symbols: String) {
        Task{
            do {
                let result = try await getHistoricalDataUseCase.excute(date: date, base: base, symbols: symbols)
             
            }catch(let error) {
                print(error)
            }
        }
    }
  
}


