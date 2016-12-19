//
//  ClientMoya.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 22/09/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

/// Implementation of the Client protocol using Moya framework.
class ClientMoya: Client {
    static let sharedInstance: ClientMoya = ClientMoya()
    
    var apiProvider: MoyaProvider<API> = MoyaProvider<API>(endpointClosure: {
        (target: API) -> Endpoint<API> in
        let endpoint: Endpoint<API> = Endpoint<API>(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding)
        let headers = ["Accept": "application/json", "Content-Type" : "application/json"]
        return endpoint.adding(newHTTPHeaderFields: headers)
    })
    
    func people(_ handler: @escaping (_ people: [Person]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        apiProvider.request(.People()) { (result) in
            switch result {
            case let .success(response):
                let json = try? response.mapJSON()
                
                if let mapping = json as? [[String : Any]] {
                    let people = Mapper<Person>().mapArray(JSONArray: mapping)!
                    handler(people)
                } else {
                    //
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func ensembles(_ handler: @escaping (_ ensembles: [Ensemble]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        apiProvider.request(.Ensembles()) { (result) in
            switch result {
            case let .success(response):
                let json = try? response.mapJSON()
                
                if let mapping = json as? [[String : Any]] {
                    let ensembles = Mapper<Ensemble>().mapArray(JSONArray: mapping)!
                    handler(ensembles)
                } else {
                    //
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func events(_ handler: @escaping (_ events: [Event]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        apiProvider.request(.Events()) { (result) in
            switch result {
            case let .success(response):
                let json = try? response.mapJSON()
                
                if let mapping = json as? [[String : Any]] {
                    let events = Mapper<Event>().mapArray(JSONArray: mapping)!
                    handler(events)
                } else {
                    //
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
}
