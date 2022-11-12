//
//  UseCase.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
protocol UseCase: AnyObject{
    associatedtype INPUT
    associatedtype OUTPUT
    func excute(input: INPUT) async throws -> OUTPUT
}
