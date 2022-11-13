//
//  CurrencyDetailsViewController.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import UIKit
import RxSwift

class CurrencyDetailsViewController: UIViewController {

    let disposeBag = DisposeBag()
    let viewModel: CurrencyDetailsViewModel
    
    init(viewModel: CurrencyDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            do {
                let result =  try await viewModel.getHistoricalDataUseCase(date: viewModel.lastThreeDays.first ?? "", base: viewModel.base, symbols: Helper.getSymboleListStringWithoutBase(array: viewModel.localSymbole, base: viewModel.base))
                print(result)
            }catch(let error){
                print(error)
            }
          
        }
    }


}
