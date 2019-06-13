//
//  WeatherNetwork.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import RxSwift

public final class WeatherNetwork {
    private let network: Network
    init(network: Network) {
        self.network = network
    }
    
    public func weather(place: String) -> Observable<Weather> {
        return network.getItem("data/2.5/weather?q=\(place)")
    }
    
    public func weathers(cities: [String]) -> Observable<[Weather]> {
        return network.getItems("data/2.5/group?id=\(cities.joined(separator: ","))&units=metric", keyName: "list")
    }
}
