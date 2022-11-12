//
//  CurrencyExchangeViewController.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import UIKit

class CurrencyExchangeViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var fromButton: UIButton!
    let viewModel: CurrencyExchangeViewModel
    init(viewModel: CurrencyExchangeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ButtonsStyling()
    }
    
    private func ButtonsStyling(){
        let buttonIcone = UIImage(systemName: "arrowtriangle.down")!
        toButton.addRightIcon(image: buttonIcone )
        fromButton.addRightIcon(image: buttonIcone)
    }

    @IBAction func toButtonDidTapped(_ sender: Any) {
        
    }
    
    @IBAction func fromButtonDidTapped(_ sender: Any) {
        
    }
    
    @IBAction func reverseButtonDidTapped(_ sender: Any) {
        
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
