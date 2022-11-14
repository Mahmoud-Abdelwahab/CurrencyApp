//
//  Helper.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 13/11/2022.
//

import Foundation
struct Helper {
    static func getSymboleListStringWithoutBase(array: [String], base: String)-> String {
        var fullString = ""
        let symboleList = array.filter({$0 != base})
        let limit = symboleList.count-1
        for i in 0...limit {
            fullString += "\(symboleList[i])"
            if i != limit{
                fullString += ","
            }
        }
        return fullString
    }
    
    static func getLastDates(forLastNDays numOfDays: Int) -> [String] {
        let cal = Calendar.current
        var date = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        var days = [String]()
        for _ in 1 ... numOfDays {
            let day = cal.component(.day, from: date!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date!)
            days.append(dateString)
            date = cal.date(byAdding: .day, value: -1, to: date!)!
        }
        return days
    }
    
    static func validateTwoSymbolesAreDifferent(sybmbole1: String, symbole2: String)-> Bool {
         sybmbole1  != symbole2
    }
}
