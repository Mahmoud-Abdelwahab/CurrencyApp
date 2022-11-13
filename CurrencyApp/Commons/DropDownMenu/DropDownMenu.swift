//
//  DropDownMenu.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
import DropDown
import RxSwift

protocol DropDownMenuProtocol: AnyObject {
    var selectedSymbolSubject:  PublishSubject<String> {get}
    func showMenu(anchore: UIView)
    func hideMenu()
}

class DropDownMenu: DropDownMenuProtocol {
    private let dropDown: DropDown
    private(set) var selectedSymbolSubject = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    init( dataSource: [String]) {
        self.dropDown = DropDown()
        dropDown.dataSource = dataSource
        dropDown.selectionAction = { [unowned self] (_, item: String) in
            selectedSymbolSubject.onNext(item)
        }
    }
    
    
    func showMenu(anchore: UIView){
        dropDown.anchorView = anchore
        dropDown.show()
    }
    
    func hideMenu() {
        dropDown.hide()
    }
}
