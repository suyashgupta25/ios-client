//
//  Router.swift
//  Gigsterous
//
//  Created by Michal Švácha on 23/12/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import Alamofire

/// Enum representing easy method navigation for networking purposes.
enum Router: URLRequestConvertible {
    static let baseURLString = Constants.serverURL
    //static var OAuthToken: String?
    
    // MARK: - Method definitions
    
    ///
    case people([String: AnyObject])
    
    ///
    case ensembles([String: AnyObject])
    
    ///
    case events([String: AnyObject])
    
    ///
    case venues([String: AnyObject])
    
    // MARK: - Query setup
    
    /// Method type (POST/GET..) for given case.
    var method: Alamofire.HTTPMethod {
        switch self {
        case .people, .ensembles, .events, .venues:
            return .post
        }
    }
    
    /// URL path for given case.
    var path: String {
        switch self {
        case .people, .ensembles, .events, .venues:
            return ""
        }
    }
    
    /// Transforms the enum case into a URLRequest
    ///
    /// - Returns: URLRequest object filled with enum data.
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Router.baseURLString)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //if let token = Router.OAuthToken {
        //    urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //}
        
        switch self {
        case .people(let parameters), .ensembles(let parameters), .events(let parameters), .venues(let parameters):
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
            //default:
            //    return urlRequest
        }
    }
}
