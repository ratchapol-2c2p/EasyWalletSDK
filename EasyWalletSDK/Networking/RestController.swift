//
//  RestController.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import Foundation
import Alamofire

typealias Generic<T> = ( T )
typealias CompletionBlock = () -> Void
typealias GenericCompletionBlock<T> = ( _ object : T ) -> Void
typealias FailureBlock = (_ error:ErrorEvent) -> Void

class RestController: NSObject {
    
    private static var manager: Session = getSession()
    
    private static func getSession() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        if Configuration.isProductionMode {
            return Session(configuration: configuration,
                           interceptor: Interceptor(),
                           serverTrustManager: ServerTrustManager(evaluators: serverTrustPolicies))
        } else {
            return Session(configuration: configuration, interceptor: Interceptor())
        }
    }
    
    static func request<T: Decodable>(with url:URLRequestConvertible,
                                      completion:@escaping GenericCompletionBlock<T>,
                                      failureBlock:@escaping FailureBlock) {
        print(url.urlRequest ?? "")
        print("\n")
        let request = manager.request(url).validate().responseString(completionHandler: { (dataString) in
        }).responseDecodable(of: T.self) { response in
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
//            .response { response in
//            switch response.result {
//            case .success(let data):
//                // Handle ResponseSerializer
//                let jsonResponse = ResponseSerializer(from: data)
//                guard jsonResponse.error == nil, let object = jsonResponse.response else {
//                    failureBlock(ErrorEvent.custom(message: jsonResponse.error?.localizedDescription))
//                    return
//                }
//                // Convert Response to Object
//                guard let result = Parse.jsonGenericObject(with: object, type: T.self) else {
//                    failureBlock(ErrorEvent.parsing)
//                    return
//                }
//                completion(result)
//                
//            case .failure(let error):
//                if let err = error.asAFError, let underlyingError = err.underlyingError?.asAFError, underlyingError.isServerTrustEvaluationError == false {
//                    failureBlock(ErrorEvent.custom(message: "Connection is not secure"))
//                } else if error.isRequestRetryError {
//                    failureBlock(ErrorEvent.custom(message: "The network connection was lost."))
//                } else {
//                    failureBlock(ErrorEvent.custom(message: error.localizedDescription))
//                }
//            }
//        }
        
        request.cURLDescription(calling: { (curl) in
           // print("\nREST Request: \(curl)\n")
        })
    }
    
    static let serverTrustPolicies: [String: ServerTrustEvaluating] = [
        Environment.baseURLDomain : PinnedCertificatesTrustEvaluator(
            certificates: getSecCertificate(),
            performDefaultValidation: true,
            validateHost: true
        ),
        Environment.oauthDomain : DisabledTrustEvaluator()
    ]
}

// MARK: Sub Method
extension RestController {
    private static func getSecCertificate() -> [SecCertificate] {
        var certs: [SecCertificate] = []
        let namesCerts = ["2c2p_2023", "2c2p_2024", "2c2p_2025"]
        for nameFile in namesCerts {
            let filePath = Bundle.main.path(forResource: nameFile, ofType: ".cer")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
            if let certificate = SecCertificateCreateWithData(nil, data as CFData) {
                certs.append(certificate)
            }
        }
        return certs
    }
}
