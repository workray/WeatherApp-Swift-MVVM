//
//  Encodable.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public protocol DomainConvertibleType {
    associatedtype DomainType: Identifiable
    
    init(with domain: DomainType)
    
    func asDomain() -> DomainType
}

public protocol Identifiable {
    var uid: String { get }
}

public typealias DomainConvertibleCoding = DomainConvertibleType

public protocol Encodable {
    associatedtype Encoder: DomainConvertibleCoding
    
    var encoder: Encoder { get }
}
