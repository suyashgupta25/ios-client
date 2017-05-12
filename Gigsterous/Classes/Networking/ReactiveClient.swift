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
    case Error(error: Error)
}

///
class ReactiveClient {
    
    ///
    func peopleSignal() -> Signal<[Person], TestError> {
        return signal(request: Router.people([:]))
    }
    
    func signal<T: Mappable>(request: URLRequestConvertible) -> Signal<[T], TestError> {
        return Signal { observer in
            
            AFClient.sharedInstance.disp(request: request) {
                (content: [T], error: Error?) -> Void in
                if let error = error {
                    observer.failed(.Error(error: error))
                } else {
                    observer.completed(with: content)
                }
            }
            
            return NonDisposable.instance
        }
    }
}
