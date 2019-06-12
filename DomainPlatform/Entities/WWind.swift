//
//  WWind.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public struct WWind {
    public let speed: Double
    public let deg: Double
    
    public init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}

extension WWind: Equatable {
    public static func == (lhs: WWind, rhs: WWind) -> Bool {
        return lhs.speed == rhs.speed &&
            lhs.deg == rhs.deg
    }
}

extension WWind: Encodable, Identifiable {
    public var uid: String {
        return "\(speed)-\(deg)"
    }
    
    public var encoder: NETWind {
        return NETWind(with: self)
    }
}

public final class NETWind: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let speed = "speed"
        static let deg = "deg"
    }
    let speed: Double
    let deg: Double
    
    public init(with domain: WWind) {
        self.speed = domain.speed
        self.deg = domain.deg
    }
    
    public init?(coder aDecoder: NSCoder) {
        guard
            let speed = aDecoder.decodeObject(forKey: Keys.speed) as? Double,
            let deg = aDecoder.decodeObject(forKey: Keys.deg) as? Double
            else {
                return nil
        }
        self.speed = speed
        self.deg = deg
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(speed, forKey: Keys.speed)
        aCoder.encode(deg, forKey: Keys.deg)
    }
    
    public func asDomain() -> WWind {
        return WWind(speed: speed, deg: deg)
    }
}
