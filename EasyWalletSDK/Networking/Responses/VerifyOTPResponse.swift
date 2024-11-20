//
//  OTPResponse.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 4/11/2567 BE.
//

import Foundation

struct VerifyOTPResponse : BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var verificationCode: String?
}
