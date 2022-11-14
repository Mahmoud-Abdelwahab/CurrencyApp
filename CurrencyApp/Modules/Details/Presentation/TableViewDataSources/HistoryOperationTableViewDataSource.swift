//
//  HistoryOperationTableViewDataSource.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import UIKit

class HistoryOperationTableViewDataSource:NSObject, UITableViewDataSource,UITableViewDelegate {
 
    var currencyList: [CurrencyDomainModel]?
    
    override init() {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        currencyList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencyList?[section].otherCurrencyList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        currencyList?[section].date
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = currencyList?[indexPath.section].otherCurrencyList[indexPath.row]
        return cell
    }
    
}
