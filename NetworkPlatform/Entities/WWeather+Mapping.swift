//
//  WWeather+Mapping.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import ObjectMapper

extension WWeather: ImmutableMappable {
    
    // JSON -> Object
    public init(map: Map) throws {
        self.init(
            id: try map.value("id"),
            main: try map.value("main"),
            description: try map.value("description"),
            icon: try map.value("icon")
        )
    }
}
