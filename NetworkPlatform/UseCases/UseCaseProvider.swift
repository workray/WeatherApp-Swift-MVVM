//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Mobdev125 on 6/12/19.
//  Copyright © 2019 Mobdev125. All rights reserved.
//

import Foundation
import DomainPlatform
import RxSwift

public final class UseCaseProvider: DomainPlatform.UseCaseProvider {
    
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeWeatherUseCase() -> DomainPlatform.WeatherUseCase {
        return WeatherUseCase(network: networkProvider.makeCheckUserNetwork())
    }
}

struct MapFromNever: Error {}
extension ObservableType where Element == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
