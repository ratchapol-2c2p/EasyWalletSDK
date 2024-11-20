//
//  OAuthRouter.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import Alamofire

enum OAuthRouter: URLRequestConvertible {

    case apiToken(params: Parameters)

    var baseURL: String {
        switch self {
        case .apiToken:          return Environment.oauthAPIURL
        }
    }

    var method: HTTPMethod {
        switch self {
        default:        return .post
        }
    }

    var path: String {
            switch self {
            case .apiToken:              return "/gac/api/\(Environment.apiVersion)/authentication/oauth2/token"
            }
        }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {

        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .apiToken(let params):
            urlRequest.httpBody = try params.data()
            urlRequest.headers.add(.contentType("application/x-www-form-urlencoded"))
            urlRequest.headers.add(.authorization(Environment.oauthKey))
        }
        return urlRequest
    }
}
