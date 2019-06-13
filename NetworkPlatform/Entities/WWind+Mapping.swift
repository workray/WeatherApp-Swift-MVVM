//
//  WWind+Mapping.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import ObjectMapper

extension WWind: ImmutableMappable {
        
    // JSON -> Object
    public init(map: Map) throws {
        self.init(
            speed: try map.value("speed"),
            deg: try map.value("deg")
        )
    }
}
