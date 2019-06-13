//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform

final class NetworkProvider {
    private let network: Network
    public init() {
        let apiEndpoint = "https://www.hellomeemo.com"
        network = Network(apiEndpoint)
    }
    
    public func makeCheckUserNetwork() -> WeatherNetwork {
        return WeatherNetwork(network: network)
    }
}
