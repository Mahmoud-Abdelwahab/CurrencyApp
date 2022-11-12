//
//  Connectivity.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Alamofire

public struct Connectivity {
    
    public static let sharedInstance = NetworkReachabilityManager()!
    
    public static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
}
