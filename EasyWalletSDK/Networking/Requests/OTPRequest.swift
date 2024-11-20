//
//  OTPRequest.swift
//  Pods
//
//  Created by Tanawat Arthan on 4/11/2567 BE.
//
import Foundation
import Alamofire

struct OTPRequest: BaseRequestProtocol {
    var email: String?
    var languageCode: String?
    
    init(email: String,languageCode:String) {
        self.email = email
        self.languageCode = languageCode
    }
}
