//
//  OAuthRequester.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import UIKit
import Alamofire

class OAuthRequester {
    
    static let shared = OAuthRequester()
    var token: String?
    
    
    // MARK: - Clear Token
    func clearToken() {
        token = nil
    }
    
    var oauthAPIResponse: OAuthResponse?
    
    func requestOAuthAPIToken(completion: @escaping GenericCompletionBlock<OAuthResponse>, failureBlock: @escaping FailureBlock) {
        do {
            let router = OAuthRouter.apiToken(params: ["grant_type": "client_credentials"])
            let urlRequest = try router.asURLRequest()
            
            let url = urlRequest.url!
            let params = ["grant_type": "client_credentials"]
            let headers = urlRequest.headers
            
            AF.request(url,
                       method: .post,
                       parameters: params,
                       headers: headers)
            .responseString(completionHandler: { responseString in
//                print("OAuth Response: ", responseString)
            })
            .responseDecodable(of: OAuthResponse.self) { response in
                switch response.result {
                case .success(let res):
                    completion(res)
                case .failure(let error):
                    if let err = error.asAFError, let underlyingError = err.underlyingError?.asAFError, underlyingError.isServerTrustEvaluationError == false {
                        failureBlock(ErrorEvent.custom(message: "Connection is not secure"))
                    } else if error.isRequestRetryError {
                        failureBlock(ErrorEvent.custom(message: "The network connection was lost."))
                    } else {
                        failureBlock(ErrorEvent.custom(message: error.localizedDescription))
                    }
                }
            }
        } catch let error {
            failureBlock(ErrorEvent.custom(message: error.localizedDescription))
        }
    }
}
