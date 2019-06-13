//
//  WeatherNavigator.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import UIKit
import DomainPlatform

protocol WeatherNavigator {
    func toWeathers()
    func toDetails(weather: Weather)
}
class DefaultWeatherNavigator: WeatherNavigator {
    let storyboard: UIStoryboard
    let navigationController: UINavigationController
    let services: UseCaseProvider
    
    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyboard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyboard = storyboard
    }
    
    func toWeathers() {
        let vc = storyboard.instantiateViewController(ofType: WeatherViewController.self)
        vc.viewModel = WeatherViewModel(useCase: services.makeWeatherUseCase(),
                                      navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toDetails(weather: Weather) {
        let navigator = DefaultDetailsNavigator(navigationController: navigationController)
        let vc = storyboard.instantiateViewController(ofType: DetailsViewController.self)
        vc.viewModel = DetailsViewModel(useCase: services.makeWeatherUseCase(),
                                        navigator: navigator,
                                        weather: weather)
        navigationController.pushViewController(vc, animated: true)
    }
}
