//
//  WeatherUseCase.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import RxSwift

final class WeatherUseCase: DomainPlatform.WeatherUseCase {
    private let network: WeatherNetwork
    
    init(network: WeatherNetwork) {
        self.network = network
    }
    
    func weather(place: String) -> Observable<Weather> {
        return network.weather(place: place)
    }
}
