//
//  Coordinator.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import UIKit


class AppCoordinator {
    
    static let shared = AppCoordinator()
    var navigationController: UINavigationController?
    let window: UIWindow

    private init() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let currencyExchangeViewController = CurrencyExchangeViewController(viewModel: CurrencyExchangeViewModel())
        navigationController = UINavigationController(rootViewController: currencyExchangeViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func navigateToCurrencyDetails(baseSymbole: String, localSymbole: [String]) {
        let currencyDetailsViewController = CurrencyDetailsViewController(viewModel: CurrencyDetailsViewModel(base: baseSymbole, localSymbols: localSymbole), historyTableViewDataSource: HistoryOperationTableViewDataSource())
        navigationController?.pushViewController(currencyDetailsViewController, animated: true)
    }
    
}
