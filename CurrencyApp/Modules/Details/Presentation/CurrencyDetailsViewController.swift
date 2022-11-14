//
//  CurrencyDetailsViewController.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import UIKit
import RxSwift

class CurrencyDetailsViewController: UIViewController {
    
    //MARK: - Outlites
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var otherCurrencyTableView: UITableView!
    @IBOutlet weak var historyTableView: UITableView!
    
    //MARK: - Variables
    let disposeBag = DisposeBag()
    let viewModel: CurrencyDetailsViewModel
    let historyTableViewDataSource: HistoryOperationTableViewDataSource?
    
    //MARK: - Initialization
    init(viewModel: CurrencyDetailsViewModel, historyTableViewDataSource : HistoryOperationTableViewDataSource) {
        self.viewModel = viewModel
        self.historyTableViewDataSource = historyTableViewDataSource
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        configureTableView()
        viewModel.fechData()
    }
    
    private func bindUI(){
        viewModel.screenState
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] in
                guard let self else {return}
                self.handleScreenState(state: $0)
            }.disposed(by: disposeBag)
    }
    
    private func handleScreenState(state: DetailsScreenState) {
        switch state {
        case .otherCurrencyData(let otherCurrencyModel):
            self.pupulatOtherCurrencyTableView(otherCurrencyList: otherCurrencyModel.otherCurrencyList)
        case .historyData(let historyModel):
            self.pupulatHistoyTableView(currencyList: historyModel.currencyList)
        case .hideLoader:
            stopLoading()
        case .showLoader:
            startLoding()
        case .showMessage(let message):
            self.showAlert(message: message)
        }
    }
    
    private func  pupulatOtherCurrencyTableView(otherCurrencyList: [String]){
        Observable.just(otherCurrencyList)
            .bind(to: otherCurrencyTableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
    }
    
    private func  pupulatHistoyTableView(currencyList: [CurrencyDomainModel]){
        historyTableViewDataSource?.currencyList = currencyList
        historyTableView.reloadData()
    }
    
    private func startLoding(){
        activityIndicator.startAnimating()
    }
    
    private func stopLoading(){
        activityIndicator.stopAnimating()
    }
}

extension CurrencyDetailsViewController: Alertable {}

extension CurrencyDetailsViewController {
    private func  configureTableView() {
        otherCurrencyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        historyTableView.dataSource = historyTableViewDataSource
        historyTableView.delegate   = historyTableViewDataSource
    }
}

