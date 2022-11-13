//
//  State.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation

enum CurrentState {
    case from
    case to
}

enum CurrencyExchangeState {
    case hideLodar
    case showLoader
    case result(String)
    case showMessage(String)
}
