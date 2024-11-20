//
//  OTPResponse.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 4/11/2567 BE.
//

import Foundation

struct OTPResponse : BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var otpPrefix: String?
}
