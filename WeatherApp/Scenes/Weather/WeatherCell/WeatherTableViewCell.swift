//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import UIKit
import DomainPlatform

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ weather: Weather) {
        cityLabel.text = weather.name
        tempLabel.text = "\(weather.main.temp)°"
        if let iconName = weather.imageName() {
            weatherIconImageView.image = UIImage(named: iconName)
        }
    }
}
