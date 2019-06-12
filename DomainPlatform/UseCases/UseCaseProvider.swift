//
//  UseCaseProvider.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public protocol UseCaseProvider {
    func makeWeatherUseCase() -> WeatherUseCase
}
