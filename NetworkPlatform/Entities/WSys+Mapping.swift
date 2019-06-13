//
//  WSys+Mapping.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import ObjectMapper

extension WSys: ImmutableMappable {

    // JSON -> Object
    public init(map: Map) throws {
        self.init(
            country: try map.value("country"),
            timezone: try map.value("timezone"),
            sunrise: try map.value("sunrise"),
            sunset: try map.value("sunset")
        )
    }
}
