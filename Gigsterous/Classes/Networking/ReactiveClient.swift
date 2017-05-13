//
//  ReactiveClient.swift
//  Gigsterous
//
//  Created by Michal Švácha on 22/12/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import ReactiveKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

enum TestError: Swift.Error {
    case error(error: Error)
}

///
class ReactiveClient {
    
    ///
    func peopleSignal() -> Signal<[Person], TestError> {
        return signal(request: Router.people([:]))
    }
    
    ///
    func eventsSignal() -> Signal<[Event], TestError> {
        return signal(request: Router.events([:]))
    }
    
    ///
    func ensemblesSignal() -> Signal<[Ensemble], TestError> {
        return signal(request: Router.ensembles([:]))
    }
    
    ///
    func venuesSignal() -> Signal<[Venue], TestError> {
        return signal(request: Router.venues([:]))
    }
    
    func signal<T: Mappable>(request: URLRequestConvertible) -> Signal<[T], TestError> {
        return Signal { observer in
            AFClient
                .sharedInstance
                .disp(request: request) { (content: [T], error: Error?) -> Void in
                    if let error = error {
                        observer.failed(.error(error: error))
                    } else {
                        observer.completed(with: content)
                    }
                }
            return NonDisposable.instance
        }
    }
}
