//
//  CurrencyDetailsViewController.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import UIKit
import RxSwift

class CurrencyDetailsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var otherCurrencyTableView: UITableView!
    @IBOutlet weak var historyTableView: UITableView!
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
        configureTableView()
        bindUI()
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
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: configureCell)
        Observable.just([SectionModel(model: "title", items: [1, 2, 3])])
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
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
        
    }
}

