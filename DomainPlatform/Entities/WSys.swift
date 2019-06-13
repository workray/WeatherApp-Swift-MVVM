//
//  WSys.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public struct WSys {
    public let country: String
    public let timezone: Int
    public let sunrise: Double
    public let sunset: Double
    
    public init(country: String, timezone: Int, sunrise: Double, sunset: Double) {
        self.country = country
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

extension WSys: Equatable {
    public static func == (lhs: WSys, rhs: WSys) -> Bool {
        return lhs.country == rhs.country &&
            lhs.timezone == rhs.timezone &&
            lhs.sunrise == rhs.sunrise &&
            lhs.sunset == rhs.sunset
    }
}

extension WSys: Encodable, Identifiable {
    public var uid: String {
        return country
    }
    
    public var encoder: NETSys {
        return NETSys(with: self)
    }
}

public final class NETSys: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let country = "country"
        static let timezone = "timezone"
        static let sunrise = "sunrise"
        static let sunset = "sunset"
    }
    let country: String
    let timezone: Int
    let sunrise: Double
    let sunset: Double
    
    public init(with domain: WSys) {
        self.country = domain.country
        self.timezone = domain.timezone
        self.sunrise = domain.sunrise
        self.sunset = domain.sunset
    }
    
    public init?(coder aDecoder: NSCoder) {
        guard
            let country = aDecoder.decodeObject(forKey: Keys.country) as? String,
            let timezone = aDecoder.decodeObject(forKey: Keys.timezone) as? Int,
            let sunrise = aDecoder.decodeObject(forKey: Keys.sunrise) as? Double,
            let sunset = aDecoder.decodeObject(forKey: Keys.sunset) as? Double
            else {
                return nil
        }
        self.country = country
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(country, forKey: Keys.country)
        aCoder.encode(timezone, forKey: Keys.timezone)
        aCoder.encode(sunrise, forKey: Keys.sunrise)
        aCoder.encode(sunset, forKey: Keys.sunset)
    }
    
    public func asDomain() -> WSys {
        return WSys(country: country, timezone: timezone, sunrise: sunrise, sunset: sunset)
    }
}
