//
//  WWeather.swift
//  DomainPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

public struct WWeather {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
    
    public init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

extension WWeather: Equatable {
    public static func == (lhs: WWeather, rhs: WWeather) -> Bool {
        return lhs.id == rhs.id &&
            lhs.main == rhs.main &&
            lhs.description == rhs.description &&
            lhs.icon == rhs.icon
    }
}

extension WWeather: Encodable, Identifiable {
    public var uid: String {
        return "\(id)"
    }
    
    public var encoder: NETWWeather {
        return NETWWeather(with: self)
    }
}

public final class NETWWeather: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let id = "id"
        static let main = "main"
        static let description = "description"
        static let icon = "icon"
    }
    let id: Int
    let main: String
    let desc: String
    let icon: String
    
    public init(with domain: WWeather) {
        self.id = domain.id
        self.main = domain.main
        self.desc = domain.description
        self.icon = domain.icon
    }
    
    public init?(coder aDecoder: NSCoder) {
        guard
            let id = aDecoder.decodeObject(forKey: Keys.id) as? Int,
            let main = aDecoder.decodeObject(forKey: Keys.main) as? String,
            let description = aDecoder.decodeObject(forKey: Keys.description) as? String,
            let icon = aDecoder.decodeObject(forKey: Keys.icon) as? String
            else {
                return nil
        }
        self.id = id
        self.main = main
        self.desc = description
        self.icon = icon
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Keys.id)
        aCoder.encode(main, forKey: Keys.main)
        aCoder.encode(desc, forKey: Keys.description)
        aCoder.encode(icon, forKey: Keys.icon)
    }
    
    public func asDomain() -> WWeather {
        return WWeather(id: id, main: main, description: desc, icon: icon)
    }
}
