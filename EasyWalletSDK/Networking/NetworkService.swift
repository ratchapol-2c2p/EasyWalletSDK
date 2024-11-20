//
//  NetworkService.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import Foundation
import Alamofire

class NetworkService {
    
    static func getOauthToken(completion: @escaping GenericCompletionBlock<OAuthResponse>, failureBlock: @escaping FailureBlock) {
        if NetworkReachabilityManager()?.isReachable ?? false == false {
            failureBlock(ErrorEvent.custom(message: "No Internet Connection"))
            return
        }
        OAuthRequester.shared.requestOAuthAPIToken(
            completion: { (response: OAuthResponse) in
                OAuthRequester.shared.token = response.accessToken
                completion(response)
        }, failureBlock: failureBlock)
    }
    
//    // MARK: - Login Flow
//    // MARK: - Verify User
//    static func verifyUser(request: VerifyUserRequest, completion: @escaping GenericCompletionBlock<VerifyUserResponse>, failureBlock: @escaping FailureBlock) {
//        if NetworkReachabilityManager()?.isReachable ?? false == false {
//            failureBlock(ErrorEvent.custom(message: "common_error_internet_not_connect".local))
//            return
//        }
////        OAuthRequester.shared.requestOAuthAPIToken(uid: request.mobileNo.unwrap(), completion: {
//            NetworkService.requestApi(.verify, request: request, completion: completion, failureBlock: failureBlock)
////        }, failureBlock: failureBlock)
//    }
//    
//    // MARK: - Login
//    static func login(request: LoginRequest, completion: @escaping GenericCompletionBlock<LoginResponse>, failureBlock: @escaping FailureBlock) {
//        if NetworkReachabilityManager()?.isReachable ?? false == false {
//            failureBlock(ErrorEvent.custom(message: "common_error_internet_not_connect".local))
//            return
//        }
//        
//        NetworkService.requestApi(.login, request: request, completion: { (response: LoginResponse) in
//            // NOTE: Only place to save token
//            OAuthRequester.shared.token = response.token
//            completion(response)
//        }, failureBlock: failureBlock)
//        
////        OAuthRequester.shared.requestOAuthAPIToken(uid: request.mobileNo.unwrap(), completion: {
////            NetworkService.requestApi(.login, request: request, completion: completion, failureBlock: failureBlock)
////        }, failureBlock: failureBlock)
//    }
//    
    // MARK: - Request API
    
    static func requestApi<T: Decodable>(_ type: ServiceApiType,
                                         request: BaseRequestProtocol? = EmptyRequest(),
                                         completion: @escaping GenericCompletionBlock<T>,
                                         failureBlock: @escaping FailureBlock) {
        if NetworkReachabilityManager()?.isReachable ?? false == false {
            failureBlock(ErrorEvent.custom(message: "Error Internet Connection"))
            return
        }
        let pathString = ServiceApis.getPath(type)
        let method = ServiceApis.getMethod(type)
        NetworkService.request(pathString,
                               request: request,
                               method: method,
                               type: type,
                               completion: completion,
                               failureBlock: failureBlock)
    }
    
    // MARK: - Private
    
    private static func request<T: Decodable>(_ pathString: String,
                                              request: BaseRequestProtocol? = EmptyRequest(),
                                              method: HTTPMethod,
                                              type: ServiceApiType,
                                              completion: @escaping GenericCompletionBlock<T>,
                                              failureBlock: @escaping FailureBlock) {
        // Request
        let router = RequestRouter(method: method,
                                   path: pathString,
                                   type: type,
                                   params: request?.getEncryptedParameters)
        
        RestController.request(with: router, completion: { (response: RawResponse) in
            self.handleRawResponse(response: response,
                                   completion: { (finalResponse) in
                completion(finalResponse)
            },
                              failureBlock: failureBlock)
        }, failureBlock: failureBlock)
    }
    
    private static func handleRawResponse<T: Decodable> (response: RawResponse,
                                          completion: @escaping GenericCompletionBlock<T>,
                                          failureBlock: @escaping FailureBlock) {
        // Check AccessToken
        guard !checkErrorAccessToken(code: response.responseCode) else {
            return
        }
        
        //   Decrypt Response from GAC
        //   Example GAC Response = { "data" : "encryptData" }
        if let data = response.data { // Have param "data" in Response
            let pgp = PGPManager()
            let decryptedString = pgp.decrypt(data: data)
            guard let result = Parse.fromJsonString(decryptedString ?? "",
                                                    type: T.self) else {
                failureBlock(ErrorEvent.parsing)
              
                return
            }
            completion(result)
            return
        } else { // Don't have param "data" in Response
            let json = Parse.convertToDictionary(from: response) ?? [:]
            do {
                let data = try JSONSerialization.data(withJSONObject: json, options: [])
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                
                completion(decodedObject)
            } catch {
                print("Decoding error: \(error)")
                failureBlock(ErrorEvent.parsing)
            }
        }
    }
    
    private static func checkErrorAccessToken(code: String?) -> Bool {
        switch code {
        case ResponseCode.invalidAccessToken:
            AlertHelpers.show(detail: "Invalid AccessToken") {
                print("OK")
            }
            return true
        case ResponseCode.accessTokenExpired:
            print("AccessToken Expired")
            AlertHelpers.show(detail: "AccessToken Expired") {
                print("OK")
            }
            return true
        default:
            return false
        }
    }
}

