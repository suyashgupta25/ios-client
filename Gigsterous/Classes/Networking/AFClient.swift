//
//  AFClient.swift
//  Gigsterous
//
//  Created by Michal Švácha on 22/12/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import Bond

///
class AFClient: NSObject {
    
    ///
    static let sharedInstance = AFClient()
    let reachabilityManager = NetworkReachabilityManager(host: "https://www.google.com")
    var isNetworkReachable = Observable<Bool>(false)
    
    ///
    private override init () {
        super.init()
        
        self.reachabilityManager?.listener = { status in
            switch status {
            case .notReachable, .unknown:
                self.isNetworkReachable.value = false
            case .reachable(_):
                self.isNetworkReachable.value = true
            }
        }
    }
    
    func disp<T: Mappable>(request: URLRequestConvertible, result: @escaping (_ content: [T], _ error: Error?) -> Void) {
        let request = Alamofire.request(request).responseObject() {
            (response: DataResponse<ResponseObject<T>>) -> Void in
            switch response.result {
            case .success(let value):
                let content = value.content ?? []
                result(content, nil)
                break
            case .failure(let error):
                result([], error)
                break
            }
        }
        request.resume()
    }
    
    ///
    func dispatch(request: URLRequestConvertible, callback: @escaping (_ response: DataResponse<Any>) -> Void) {
        if !self.isNetworkReachable.value {
            let response = DataResponse<Any>(
                request: nil,
                response: nil,
                data: nil,
                result: Result.failure(NSError(domain: "", code: 0, userInfo: nil) as Error))
            callback(response)
            return
        }
        
        Alamofire
            .request(request)
            .responseJSON { (response) -> Void in
                callback(response)
        }
    }
}
