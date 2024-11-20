//
//  VerifyUserByEmailRequest.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 7/10/2567 BE.
//

import Foundation
import Alamofire

struct VerifyUserByEmailRequest: BaseRequestProtocol {
    var email: String?
    var deviceId: String?
    
    init(email: String) {
        self.email = email
        self.deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}
