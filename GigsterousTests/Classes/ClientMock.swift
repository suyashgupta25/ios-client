//
//  ClientMock.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 22/09/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import OHHTTPStubs

/// Mock implementation of the Client protocol for prototyping and testing purposes.
class ClientMock: Client {
    static let sharedInstance: ClientMock = ClientMock()
    
    func people(_ handler: @escaping (_ people: [Person]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        _ = stub(condition: isScheme("https") && isHost("api.gigsterous.com") && isPath("/people")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile(
                    "people.json",
                    type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type" : "application/json"])
        }
        
        ClientMoya.sharedInstance.people({ (people: [Person]) in
            handler(people)
        }) { (error: NSError) in
            failure(error)
        }
    }
    
    func ensembles(_ handler: @escaping (_ ensembles: [Ensemble]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        _ = stub(condition: isScheme("https") && isHost("api.gigsterous.com") && isPath("/ensembles")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile(
                    "ensembles.json",
                    type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type" : "application/json"])
        }
        
        ClientMoya.sharedInstance.ensembles({ (ensembles: [Ensemble]) in
            handler(ensembles)
        }) { (error: NSError) in
            failure(error)
        }
    }
    
    func events(_ handler: @escaping (_ events: [Event]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        _ = stub(condition: isScheme("https") && isHost("api.gigsterous.com") && isPath("/events")) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile(
                    "events.json",
                    type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"])
        }
        
        ClientMoya.sharedInstance.events({ (events: [Event]) in
            handler(events)
        }) { (error: NSError) in
            failure(error)
        }
    }
}
