//
//  ApiError.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public enum ApiError: Error {
    case authentication
    case unknown
    case other(reason: String)
}
