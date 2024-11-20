//
//  BaseRequest.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 7/10/2567 BE.
//

import Foundation
import Alamofire

protocol BaseRequestProtocol: Jsonable {
    var parameters: Parameters? { get }
}

extension BaseRequestProtocol {
    var parameters: Parameters? {
        get {
            guard let dict = self.toJson() else {  return [:]  }
            return dict
        }
    }
    
    var getEncryptedParameters: Parameters? {
        get {
            guard let dict = self.toJson() else {  return [:]  }
            let pgp = PGPManager()
            let encrypted = pgp.encrypt(data: dict)
            let param: [String: Any] = ["data": encrypted ?? "-"]
            return param
        }
    }
}

struct EmptyRequest: BaseRequestProtocol {
    var parameters: Parameters? { get { return nil } }
}
