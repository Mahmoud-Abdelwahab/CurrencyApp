//
//  Alertable.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import UIKit
public protocol Alertable {}

public extension Alertable where Self: UIViewController {
    func showAlert(title: String = "ALERT", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
