//
//  ConsentListRequest.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 10/10/2567 BE.
//

import Foundation
import Alamofire

struct ConsentListRequest: BaseRequestProtocol {
    var language: String?
    
    init(language: String? = "EN") {
        self.language = language
    }
}
