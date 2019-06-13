//
//  DetailsNavigator.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import UIKit
import DomainPlatform

protocol DetailsNavigator {
    
}

class DefaultDetailsNavigator: DetailsNavigator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
}
