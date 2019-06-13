//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import RxSwift
import RxCocoa

final class WeatherViewModel: ViewModelType {
    
    private let useCase: WeatherUseCase
    private let navigator: WeatherNavigator
    
    private let NEW_JERSEY = "5101760"
    private let LONDON = "2643743"
    private let TOKYO = "1850147"
    
    init(useCase: WeatherUseCase, navigator: WeatherNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let cities = [NEW_JERSEY, LONDON, TOKYO]
        let weathers = input.initialTrigger.flatMapLatest {
            return self.useCase.weathers(cities: cities)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let selectedCity = input.selectionTrigger
            .withLatestFrom(weathers) { (indexPath, weathers) -> Weather in
                return weathers[indexPath.row]
            }
            .do(onNext: navigator.toDetails)
        return Output(
            fetching: fetching,
            weathers: weathers,
            selectedCity: selectedCity,
            error: errors
        )
    }
}

extension WeatherViewModel {
    struct Input {
        let initialTrigger: Driver<Void>
        let selectionTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let weathers: Driver<[Weather]>
        let selectedCity: Driver<Weather>
        let error: Driver<Error>
    }
}
