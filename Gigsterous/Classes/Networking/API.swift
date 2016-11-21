//
//  GigsterousEndpoint.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 22/09/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import Moya
import Alamofire

/// Endpoint specification
enum API {
    case People()
    case Ensembles()
    case Events()
}

extension API: TargetType {
    
    public var baseURL: URL {
        return URL(string: Constants.serverURL)!
    }
    
    public var path: String {
        switch self {
        case .People():
            return "/people"
        case .Ensembles():
            return "/ensembles"
        case .Events():
            return "/events"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .People(), .Ensembles(), .Events():
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .People(), .Ensembles(), .Events():
            return nil
        }
    }
    
    public var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        default:
            return JSONEncoding()
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .People(), .Ensembles(), .Events():
            return "{}".UTF8EncodedData
        }
    }
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var UTF8EncodedData: Data {
        return self.data(using: String.Encoding.utf8)!
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
