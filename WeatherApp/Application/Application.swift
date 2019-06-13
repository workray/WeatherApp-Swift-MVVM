//
//  Application.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform
import NetworkPlatform

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: DomainPlatform.UseCaseProvider
    private var window: UIWindow?
    
    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
    
    func initialize(window: UIWindow) {
        self.window = window;
    }
    
    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = UINavigationController()
        let navigator = DefaultWeatherNavigator(services: networkUseCaseProvider,
                                                     navigationController: navigationController,
                                                     storyboard: storyboard)
        
        window.rootViewController = navigationController
        
        navigator.toWeathers()
    }
}

