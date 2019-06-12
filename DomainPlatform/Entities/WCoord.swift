//
//  Coord.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public struct WCoord {
    public let lon: Double
    public let lat: Double
    
    public init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}

extension WCoord: Equatable {
    public static func == (lhs: WCoord, rhs: WCoord) -> Bool {
        return lhs.lon == rhs.lon &&
            lhs.lat == rhs.lat
    }
}

extension WCoord: Encodable, Identifiable {
    public var uid: String {
        return "\(lon)-\(lat)"
    }
    
    public var encoder: NETCoord {
        return NETCoord(with: self)
    }
}

public final class NETCoord: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let lon = "lon"
        static let lat = "lat"
    }
    let lon: Double
    let lat: Double
    
    public init(with domain: WCoord) {
        self.lon = domain.lon
        self.lat = domain.lat
    }
    
    public init?(coder aDecoder: NSCoder) {
        guard
            let lon = aDecoder.decodeObject(forKey: Keys.lon) as? Double,
            let lat = aDecoder.decodeObject(forKey: Keys.lat) as? Double
            else {
                return nil
        }
        self.lon = lon
        self.lat = lat
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(lon, forKey: Keys.lon)
        aCoder.encode(lat, forKey: Keys.lat)
    }
    
    public func asDomain() -> WCoord {
        return WCoord(lon: lon, lat: lat)
    }
}
