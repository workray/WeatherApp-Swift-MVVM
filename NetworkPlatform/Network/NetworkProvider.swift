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
        let apiEndpoint = "https://api.openweathermap.org"
        let apiKey = "bae7b2425b91a9fb15c8a28b147b34ce"
        network = Network(apiEndpoint, apiKey)
    }
    
    public func makeCheckUserNetwork() -> WeatherNetwork {
        return WeatherNetwork(network: network)
    }
}
