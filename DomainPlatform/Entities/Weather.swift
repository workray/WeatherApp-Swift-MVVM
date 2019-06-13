//
//  Weather.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public struct Weather {
    public let id: Int
    public let name: String
    public let coord: WCoord
    public let sys: WSys
    public let weather: [WWeather]
    public let main: WMain
    public let wind: WWind
    public let clouds: [String: Any]
    public let dt: Int
    
    public init(id: Int, name: String, coord: WCoord, sys: WSys, weather: [WWeather], main: WMain, wind: WWind, clouds: [String: Any], dt: Int) {
        self.id = id
        self.name = name
        self.coord = coord
        self.sys = sys
        self.weather = weather
        self.main = main
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
    }
}

extension Weather: Equatable {
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.coord == rhs.coord &&
            lhs.sys == rhs.sys &&
            lhs.weather == rhs.weather &&
            lhs.wind == rhs.wind &&
            lhs.dt == rhs.dt
    }
}

extension Weather: Encodable, Identifiable {
    public var uid: String {
        return "\(id)"
    }
    
    public var encoder: NETWeather {
        return NETWeather(with: self)
    }
}

public final class NETWeather: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let id = "id"
        static let name = "name"
        static let coord = "coord"
        static let sys = "sys"
        static let weather = "weather"
        static let main = "main"
        static let wind = "wind"
        static let clouds = "clouds"
        static let dt = "dt"
    }
    let id: Int
    let name: String
    let coord: WCoord
    let sys: WSys
    let weather: [WWeather]
    let main: WMain
    let wind: WWind
    let clouds: [String: Any]
    let dt: Int
    
    public init(with domain: Weather) {
        self.id = domain.id
        self.name = domain.name
        self.coord = domain.coord
        self.sys = domain.sys
        self.weather = domain.weather
        self.main = domain.main
        self.wind = domain.wind
        self.clouds = domain.clouds
        self.dt = domain.dt
    }
    
    public init?(coder aDecoder: NSCoder) {
        guard
            let id = aDecoder.decodeObject(forKey: Keys.id) as? Int,
            let name = aDecoder.decodeObject(forKey: Keys.name) as? String,
            let coord = aDecoder.decodeObject(forKey: Keys.coord) as? NETCoord,
            let sys = aDecoder.decodeObject(forKey: Keys.sys) as? NETSys,
            let weather = aDecoder.decodeObject(forKey: Keys.weather) as? [NETWWeather],
            let main = aDecoder.decodeObject(forKey: Keys.main) as? NETMain,
            let wind = aDecoder.decodeObject(forKey: Keys.wind) as? NETWind,
            let clouds = aDecoder.decodeObject(forKey: Keys.clouds) as? [String: Any],
            let dt = aDecoder.decodeObject(forKey: Keys.dt) as? Int
            else {
                return nil
        }
        self.id = id
        self.name = name
        self.coord = coord.asDomain()
        self.sys = sys.asDomain()
        self.weather = weather.map{ $0.asDomain() }
        self.main = main.asDomain()
        self.wind = wind.asDomain()
        self.clouds = clouds
        self.dt = dt
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Keys.id)
        aCoder.encode(name, forKey: Keys.name)
        aCoder.encode(coord, forKey: Keys.coord)
        aCoder.encode(sys, forKey: Keys.sys)
        aCoder.encode(weather, forKey: Keys.weather)
        aCoder.encode(main, forKey: Keys.main)
        aCoder.encode(wind, forKey: Keys.wind)
        aCoder.encode(clouds, forKey: Keys.clouds)
        aCoder.encode(dt, forKey: Keys.dt)
    }
    
    public func asDomain() -> Weather {
        return Weather(id: id, name: name, coord: coord, sys: sys, weather: weather, main: main, wind: wind, clouds: clouds, dt: dt)
    }
}
