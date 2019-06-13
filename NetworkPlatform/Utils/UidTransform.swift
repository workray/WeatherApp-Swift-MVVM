//
//  UidTransform.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import ObjectMapper

class UidTransform: TransformType {
    
    typealias Object = String
    typealias JSON = Int
    
    init() {}
    
    func transformFromJSON(_ value: Any?) -> String? {
        if let uidInt = value as? Int {
            return String(uidInt)
        }
        
        if let uidStr = value as? String {
            return uidStr
        }
        
        return nil
    }
    
    func transformToJSON(_ value: String?) -> Int? {
        if let uid = value {
            return Int(uid)
        }
        return nil
    }
}


