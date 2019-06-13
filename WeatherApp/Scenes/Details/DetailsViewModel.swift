//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import RxCocoa
import RxSwift

final class DetailsViewModel: ViewModelType {
    
    private let authUseCase: WeatherUseCase
    private let navigator: DetailsNavigator
    private let weather: Weather
    
    init(useCase: WeatherUseCase, navigator: DetailsNavigator, weather: Weather) {
        self.navigator = navigator
        self.authUseCase = useCase
        self.weather = weather
    }
    
    func transform(input: Input) -> Output {
        
        return Output(
            details: Driver.just(self.weather)
        )
    }
}

extension DetailsViewModel {
    struct Input {
    }
    
    struct Output {
        let details: Driver<Weather>
    }
}
