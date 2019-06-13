//
//  Weather+Mapping.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import ObjectMapper

extension Weather: ImmutableMappable {
    
    // JSON -> Object
    public init(map: Map) throws {
        self.init(
            id: try map.value("id"),
            name: try map.value("name"),
            coord: try map.value("coord"),
            sys: try map.value("sys"),
            weather: try map.value("weather"),
            main: try map.value("main"),
            wind: try map.value("wind"),
            rain: try map.value("rain"),
            clouds: try map.value("clouds"),
            dt: try map.value("dt"),
            cod: try map.value("cod")
        )
    }
}
