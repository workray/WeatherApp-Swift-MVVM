//
//  Weather+Ext.swift
//  WeatherApp
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import DomainPlatform

protocol WeatherIconMap {
    func imageName() -> String?
}

protocol WeatherSunTimeMap {
    func sunrise() -> String
    func sunset() -> String
}

extension Weather: WeatherIconMap {
    static let imageMap = {
        return [
            "01d" : "weather-clear",
            "02d" : "weather-few",
            "03d" : "weather-few",
            "04d" : "weather-broken",
            "09d" : "weather-shower",
            "10d" : "weather-rain",
            "11d" : "weather-tstorm",
            "13d" : "weather-snow",
            "50d" : "weather-mist",
            "01n" : "weather-moon",
            "02n" : "weather-few-night",
            "03n" : "weather-few-night",
            "04n" : "weather-broken",
            "09n" : "weather-shower",
            "10n" : "weather-rain-night",
            "11n" : "weather-tstorm",
            "13n" : "weather-snow",
            "50n" : "weather-mist"
        ]
    }()
    
    func imageName() -> String? {
        if weather.count > 0 {
            return Weather.imageMap[self.weather[0].icon]
        }
        return nil
    }
}

extension Weather : WeatherSunTimeMap {
    func timeString(time: Double, timezone: Int) -> String {
        let sunriseDate = Date(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: timezone)
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        
        return formatter.string(from: sunriseDate)
    }
    func sunrise() -> String {
        return timeString(time: self.sys.sunrise, timezone: self.sys.timezone)
    }
    
    func sunset() -> String {
        return timeString(time: self.sys.sunset, timezone: self.sys.timezone)
    }
}
