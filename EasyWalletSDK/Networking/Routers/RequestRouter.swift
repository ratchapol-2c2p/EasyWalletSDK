//
//  RequestRouter.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 7/10/2567 BE.
//

import Foundation
import Alamofire

struct RequestRouter: URLRequestConvertible {
    
    var baseURL: String = Environment.baseURL
    var method: HTTPMethod = .post
    var path: String = ""
    var type: ServiceApiType?
    var params: Parameters? = nil
    
    init(path: String, type: ServiceApiType, params: Parameters? = nil) {
        self.path = path
        self.params = params
        self.type = type
    }
    
    init(method: HTTPMethod, path: String, type: ServiceApiType, params: Parameters? = nil) {
        self.method = method
        self.path = path
        self.params = params
        self.type = type
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.headers.add(.contentType("application/json"))
        if let token = OAuthRequester.shared.token {
            urlRequest.headers.add(.authorization(bearerToken: token + "-"))
        }
//        let language = DeviceInfo.shared.currentLanguage.acceptLanguage
//        urlRequest.headers.add(.acceptLanguage(language))
//        
//        let appVersion = DeviceInfo.shared.appVersion
//        urlRequest.headers.add(.init(name: Constants.appVersionHeader, value: appVersion))
//        
//        let appPlatform = DeviceInfo.shared.platform
//        urlRequest.headers.add(.init(name: Constants.appPlatform, value: appPlatform))
        
        switch type {
        default:
            urlRequest.httpBody = try params?.data()
        }
        return urlRequest
    }
}
