//
//  WCoord+Mapping.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import ObjectMapper

extension WCoord: ImmutableMappable {
    
    // JSON -> Object
    public init(map: Map) throws {
        self.init(
            lon: try map.value("lon"),
            lat: try map.value("lat")
        )
    }
}
