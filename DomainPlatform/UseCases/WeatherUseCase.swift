//
//  WeatherUseCase.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import RxSwift

public protocol WeatherUseCase {
    func weather(place: String) -> Observable<Weather>
    func weathers(cities: [String]) -> Observable<[Weather]>
}
