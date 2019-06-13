//
//  Network.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import Foundation
import Alamofire
import DomainPlatform
import RxAlamofire
import RxSwift
import ObjectMapper

final class Network {
    
    private let endPoint: String
    private let apiKey: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String, _ apiKey: String) {
        self.endPoint = endPoint
        self.apiKey = apiKey
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    // MARK: Multiple Items
    func getItems<T: ImmutableMappable>(_ path: String, keyName: String? = nil) -> Observable<[T]> {
        let absolutePath = "\(endPoint)/\(path)&appid=\(apiKey)"
        return requestItems(.get, path: absolutePath, parameters: nil, keyName: keyName)
    }
    
    func postItems<T: ImmutableMappable>(_ path: String, parameters: [String: Any], keyName: String? = nil) -> Observable<[T]> {
        let absolutePath = "\(endPoint)/\(path)&appid=\(apiKey)"
        return requestItems(.post, path: absolutePath, parameters: parameters, keyName: keyName)
    }
    
    // MARK: Single Item
    func getItem<T: ImmutableMappable>(_ path: String, itemId: String? = nil, keyName: String? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)\(itemId == nil ? "" : "/\(itemId!)")&appid=\(apiKey)"
        return request(.get, path: absolutePath, parameters: nil, keyName: keyName)
    }
    
    func postItem<T: ImmutableMappable>(_ path: String, parameters: [String: Any], keyName: String? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return request(.post, path: absolutePath, parameters: parameters, keyName: keyName)
    }
    
    func updateItem<T: ImmutableMappable>(_ path: String, itemId: String? = nil, parameters: [String: Any], keyName: String? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)\(itemId == nil ? "" : "/\(itemId!)")"
        return request(.put, path: absolutePath, parameters: parameters, keyName: keyName)
    }
    
    func deleteItem<T: ImmutableMappable>(_ path: String, itemId: String? = nil, keyName: String? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)\(itemId == nil ? "" : "/\(itemId!)")"
        return request(.delete, path: absolutePath, parameters: [:], keyName: keyName)
    }
    
    func deleteItem(_ path: String, itemId: String? = nil) -> Observable<Void> {
        let absolutePath = "\(endPoint)/\(path)\(itemId == nil ? "" : "/\(itemId!)")"
        return RxAlamofire
            .request(.delete, absolutePath, parameters: nil, encoding: JSONEncoding.default, headers: requestHeader())
            .debug()
            .observeOn(scheduler)
            .map { _ in }
    }
    
    fileprivate func request<T: ImmutableMappable>(_ method: Alamofire.HTTPMethod, path: String, parameters: [String: Any]?, keyName: String? = nil) -> Observable<T> {
        return RxAlamofire
            .request(method, path, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeader())
            .debug()
            .observeOn(scheduler)
            .responseData()
            .map({ (response, data) -> T in
                do {
                    if response.statusCode == 401 || response.statusCode == 404 || response.statusCode == 422 {
                        throw ApiError.authentication
                    }
                    else {
                        let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        if let dict = dict as? [String: Any] {
                            if let errors = dict["errors"] as? [String] {
                                throw ApiError.other(reason: errors.first ?? "Unknow Error")
                            }
                            if let key = keyName, let values = dict[key] as? [String: Any] {
                                return try Mapper<T>().map(JSONObject: values)
                            }
                            return try Mapper<T>().map(JSONObject: dict)
                        }
                        throw ApiError.unknown
                    }
                }
                catch {
                    print(String(data: data, encoding: .utf8) ?? "")
                    print("API Error: \(error.localizedDescription)")
                    print("PATH: \(path)")
                    print("PARAMS: \(parameters ?? [:])")
                    throw error
                }
            })
    }
    
    fileprivate func requestItems<T: ImmutableMappable>(_ method: Alamofire.HTTPMethod, path: String, parameters: [String: Any]?, keyName: String? = nil) -> Observable<[T]> {
        return RxAlamofire
            .request(method, path, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeader())
            .debug()
            .observeOn(scheduler)
            .responseData()
            .map({ (response, data) -> [T] in
                do {
                    if response.statusCode == 401 || response.statusCode == 404 {
                        throw ApiError.authentication
                    }
                    else {
                        let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        if let dict = dict as? [String: Any] {
                            if let errors = dict["errors"] as? [String] {
                                throw ApiError.other(reason: errors.first ?? "Unknow Error")
                            }
                            else if let key = keyName, let values = dict[key] as? [[String: Any]] {
                                return try Mapper<T>().mapArray(JSONObject: values)
                            }
                            throw ApiError.unknown
                        }
                        else if let array = dict as? [[String: Any]] {
                            return try Mapper<T>().mapArray(JSONObject: array)
                        }
                    }
                    throw ApiError.unknown
                }
                catch {
                    print(String(data: data, encoding: .utf8) ?? "")
                    print("API Error: \(error.localizedDescription)")
                    print("PATH: \(path)")
                    print("PARAMS: \(parameters ?? [:])")
                    throw error
                }
            })
    }
    
    fileprivate func requestHeader() -> [String: String] {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": token
        ]
    }
}
