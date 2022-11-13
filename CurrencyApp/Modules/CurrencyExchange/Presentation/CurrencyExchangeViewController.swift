//
//  CurrencyExchangeViewController.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
class CurrencyExchangeViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var fromButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel: CurrencyExchangeViewModel
    var myMenu: DropDownMenuProtocol?
    
    init(viewModel: CurrencyExchangeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        doExchange(from: viewModel.fromSubject.value, to: viewModel.toSubject.value, amount: viewModel.amountSubject.value)
        ButtonsStyling()
        setupDropDownMenu()
        setupUI()
     
    }
    
    private func ButtonsStyling(){
        let buttonIcone = UIImage(systemName: "arrowtriangle.down")!
        toButton.addRightIcon(image: buttonIcone )
        fromButton.addRightIcon(image: buttonIcone)
    }
    
    private func setupDropDownMenu() {
        self.myMenu =  DropDownMenu( dataSource: viewModel.getCurrencySymboleList())
        self.myMenu?.selectedSymbolSubject.subscribe(onNext: {[weak self] in
            guard let self else{return}
            switch self.viewModel.currentState{
            case .from:
                self.fromButton.setTitle($0, for: .normal)
            case .to:
                self.toButton.setTitle($0, for: .normal)
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        fromTextField.text = viewModel.amountSubject.value.description
    }
    
    private func bindUI() {
        
        viewModel
            .fromSubject
            .withUnretained(self)
            .subscribe(onNext: {
                $0.0.fromButton.setTitle($0.1, for: .normal)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .toSubject
            .withUnretained(self)
            .subscribe(onNext: {
                $0.0.toButton.setTitle($0.1, for: .normal)
            })
            .disposed(by: disposeBag)
        
        
        viewModel
            .screenSubject
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] state in
                guard let self else {return}
                self.handleScreenState(state: state)
            }.disposed(by: disposeBag)
        
    
        fromTextField.rx.text
            .skip(1)
            .observe(on: MainScheduler.instance)
            .debounce(.milliseconds(700), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .compactMap({$0?.toDouble()})
            .do(onNext: {_ in self.viewModel.currentState = .from})
            .bind(to: self.viewModel.amountSubject)
            .disposed(by: disposeBag)

        toTextField.rx.text
            .skip(1)
            .observe(on: MainScheduler.instance)
            .debounce(.milliseconds(700), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .compactMap({$0?.toDouble()})
            .do(onNext: {_ in self.viewModel.currentState = .to})
            .bind(to: self.viewModel.amountSubject)
            .disposed(by: disposeBag)

        
        viewModel.amountSubject.subscribe(onNext: {[weak self] in
            guard let self = self else {return}
            self.onAmountChanged(amount: $0)
        }).disposed(by: disposeBag)
                
    }
    
    private func onAmountChanged(amount: Double) {
        var from = ""
        var to   = ""
        switch self.viewModel.currentState {
        case .from:
            from = self.viewModel.fromSubject.value
            to   = self.viewModel.toSubject.value
        case .to:
            from = self.viewModel.toSubject.value
            to   = self.viewModel.fromSubject.value
        }
        self.doExchange(from: from, to: to, amount: amount)
    }
    
    func handleScreenState(state: CurrencyExchangeState) {
        switch state {
        case .hideLodar:
            stopLoading()
        case .showLoader:
            startLoding()
        case .result(let text):
            self.bindResultText(text: text)
        case .showMessage(let message):
            self.showAlert(message: message)
        }
    }

    private func doExchange(from: String, to: String, amount: Double){
        Task{
            viewModel.doExchange(from: from, to: to, amount: amount)
        }
    }
    
    private func bindResultText(text: String){
        switch viewModel.currentState {
        case .from:
            toTextField.text = text
        case .to:
            fromTextField.text = text
        }
    }
    
    @IBAction func toButtonDidTapped(_ sender: UIButton) {
        viewModel.currentState = .to
        myMenu?.showMenu(anchore: sender)

    }
    
    @IBAction func fromButtonDidTapped(_ sender: UIButton) {
        viewModel.currentState = .from
        myMenu?.showMenu(anchore: sender)
    }
    
    @IBAction func reverseButtonDidTapped(_ sender: Any) {
        let temp = viewModel.fromSubject.value
        viewModel.fromSubject.accept(viewModel.toSubject.value)
        viewModel.toSubject.accept(temp)
        doExchange(from: viewModel.fromSubject.value, to: viewModel.toSubject.value, amount: viewModel.amountSubject.value)
    }
    
    @IBAction func detailsButtonDidTapped(_ sender: Any) {
        
    }
    
    
    private func startLoding(){
        activityIndicator.startAnimating()
    }
    
    private func stopLoading(){
        activityIndicator.stopAnimating()
    }
}

extension CurrencyExchangeViewController: Alertable {}
