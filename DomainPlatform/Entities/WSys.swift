//
//  WSys.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public struct WSys {
    public let country: String
    public let sunrise: UInt
    public let sunset: UInt
    
    public init(country: String, sunrise: UInt, sunset: UInt) {
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

extension WSys: Equatable {
    public static func == (lhs: WSys, rhs: WSys) -> Bool {
        return lhs.country == rhs.country &&
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
        static let sunrise = "sunrise"
        static let sunset = "sunset"
    }
    let country: String
    let sunrise: UInt
    let sunset: UInt
    
    public init(with domain: WSys) {
        self.country = domain.country
        self.sunrise = domain.sunrise
        self.sunset = domain.sunset
    }
    
    public init?(coder aDecoder: NSCoder) {
        guard
            let country = aDecoder.decodeObject(forKey: Keys.country) as? String,
            let sunrise = aDecoder.decodeObject(forKey: Keys.sunrise) as? UInt,
            let sunset = aDecoder.decodeObject(forKey: Keys.sunset) as? UInt
            else {
                return nil
        }
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(country, forKey: Keys.country)
        aCoder.encode(sunrise, forKey: Keys.sunrise)
        aCoder.encode(sunset, forKey: Keys.sunset)
    }
    
    public func asDomain() -> WSys {
        return WSys(country: country, sunrise: sunrise, sunset: sunset)
    }
}
