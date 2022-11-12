//
//  Constants.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//

import Foundation
enum Constants {
    static var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        return value
      }
    }
    
    static var baseURL: String {
     get {
       guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
         fatalError("Couldn't find file 'Info.plist'.")
       }
       let plist = NSDictionary(contentsOfFile: filePath)
       guard let value = plist?.object(forKey: "BASE_URL") as? String else {
         fatalError("Couldn't find key 'BASE_URL' in 'Info.plist'.")
       }
       return value
     }
   }
    
}
