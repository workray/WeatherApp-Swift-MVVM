//
//  WMain+Mapping.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import ObjectMapper

extension WMain: ImmutableMappable {
    
    // JSON -> Object
    public init(map: Map) throws {
        self.init(
            temp: try map.value("temp"),
            humidity: try map.value("humidity"),
            pressure: try map.value("pressure"),
            temp_min: try map.value("temp_min"),
            temp_max: try map.value("temp_max")
        )
    }
}
