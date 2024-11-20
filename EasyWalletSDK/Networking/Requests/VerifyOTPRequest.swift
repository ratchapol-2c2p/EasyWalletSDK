//
//  OTPRequest.swift
//  Pods
//
//  Created by Tanawat Arthan on 4/11/2567 BE.
//
import Foundation
import Alamofire

struct VerifyOTPRequest: BaseRequestProtocol {
    var email: String?
    var otpPrefix: String?
    var otpValue: String?

    init(email: String,otpPrefix:String,otpValue:String) {
        self.email = email
        self.otpPrefix = otpPrefix
        self.otpValue = otpValue
    }
}
