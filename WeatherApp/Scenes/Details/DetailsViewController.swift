//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import UIKit
import DomainPlatform
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    var viewModel: DetailsViewModel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    

    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = DetailsViewModel.Input()
        let output = viewModel.transform(input: input)
        output.details
            .drive(weatherBinding)
            .disposed(by: disposeBag)
    }

    var weatherBinding: Binder<Weather> {
        return Binder(self, binding: { (vc, weather) in
            vc.title = weather.name
            if let iconName = weather.imageName() {
                vc.weatherIconImageView.image = UIImage(named: iconName)
            }
            if weather.weather.count > 0 {
                vc.mainLabel.text = weather.weather[0].main
                vc.descriptionLabel.text = weather.weather[0].description
            }
            vc.tempLabel.text = "\(weather.main.temp)°"
            vc.minTempLabel.text = "min: \(weather.main.temp_min)°"
            vc.maxTempLabel.text = "max: \(weather.main.temp_max)°"
            vc.pressureLabel.text = "pressure: \(weather.main.pressure)"
            vc.humidityLabel.text = "humidity: \(weather.main.humidity)"
            vc.sunriseLabel.text = "sunrise: \(weather.sunrise())"
            vc.sunsetLabel.text = "sunset: \(weather.sunset())"
            vc.windSpeedLabel.text = "speed: \(weather.wind.speed) m/s"
            vc.windDegLabel.text = "deg: \(weather.wind.deg)°"
        })
    }
}
