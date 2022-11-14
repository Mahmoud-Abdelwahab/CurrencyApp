//
//  BaseResponse.swift
//  CurrencyApp
//
//  Created by Mahmoud Abdul-wahab on 12/11/2022.
//
import Foundation

public protocol BaseResponseProtocol: Codable {
    associatedtype NetworkModel
    var data: NetworkModel? { get set }
    var success: Bool? { get set }
    var error: ResponseError? { get set }
}

// MARK: Base response
public struct BaseResponse<T: Codable>: BaseResponseProtocol {    
    public typealias NetworkModel = T
    public  var success: Bool?
    public var data: T?
    public var error: ResponseError?
}

// MARK: - Error
public struct ResponseError: Codable {
    let code: Int?
    let message, type, info: String?
}
