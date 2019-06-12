//
//  WMain.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public struct WMain {
    public let temp: Double
    public let humidity: Double
    public let pressure: Double
    public let temp_min: Double
    public let temp_max: Double
    
    public init(temp: Double, humidity: Double, pressure: Double, temp_min: Double, temp_max: Double) {
        self.temp = temp
        self.humidity = humidity
        self.pressure = pressure
        self.temp_min = temp_min
        self.temp_max = temp_max
    }
}

extension WMain: Equatable {
    public static func == (lhs: WMain, rhs: WMain) -> Bool {
        return lhs.temp == rhs.temp &&
            lhs.humidity == rhs.humidity &&
            lhs.pressure == rhs.pressure &&
            lhs.temp_min == rhs.temp_min &&
            lhs.temp_max == rhs.temp_max
    }
}

extension WMain: Encodable, Identifiable {
    public var uid: String {
        return "\(temp)-\(humidity)-\(pressure)"
    }
    
    public var encoder: NETMain {
        return NETMain(with: self)
    }
}

public final class NETMain: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let temp = "temp"
        static let humidity = "humidity"
        static let pressure = "pressure"
        static let temp_min = "temp_min"
        static let temp_max = "temp_max"
    }
    let temp: Double
    let humidity: Double
    let pressure: Double
    let temp_min: Double
    let temp_max: Double
    
    public init(with domain: WMain) {
        self.temp = domain.temp
        self.humidity = domain.humidity
        self.pressure = domain.pressure
        self.temp_min = domain.temp_min
        self.temp_max = domain.temp_max
    }
    
    public init?(coder aDecoder: NSCoder) {
        guard
            let temp = aDecoder.decodeObject(forKey: Keys.temp) as? Double,
            let humidity = aDecoder.decodeObject(forKey: Keys.humidity) as? Double,
            let pressure = aDecoder.decodeObject(forKey: Keys.pressure) as? Double,
            let temp_min = aDecoder.decodeObject(forKey: Keys.temp_min) as? Double,
            let temp_max = aDecoder.decodeObject(forKey: Keys.temp_max) as? Double
            else {
                return nil
        }
        self.temp = temp
        self.humidity = humidity
        self.pressure = pressure
        self.temp_min = temp_min
        self.temp_max = temp_max
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(temp, forKey: Keys.temp)
        aCoder.encode(humidity, forKey: Keys.humidity)
        aCoder.encode(pressure, forKey: Keys.pressure)
        aCoder.encode(temp_min, forKey: Keys.temp_min)
        aCoder.encode(temp_max, forKey: Keys.temp_max)
    }
    
    public func asDomain() -> WMain {
        return WMain(temp: temp, humidity: humidity, pressure: pressure, temp_min: temp_min, temp_max: temp_max)
    }
}
