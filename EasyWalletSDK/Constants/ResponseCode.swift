//
//  ResponseCode.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 8/10/2567 BE.
//

import Foundation

struct ResponseCode {
    static let invalidAccessToken = "A01"
    static let accessTokenExpired = "A02"
    static let mobileNotFoundOrTerminated = "U01"
    static let accountLocked = "U03"
    static let userNeedToChangePasscode = "U04"
    static let emailAlreadyRegistered = "U09"
    static let emailNotFoundOrTerminated = "U02"
    static let deviceIDNotMatch = "U07"
    static let deviceIDNotMatchAndNotSetPasscode = "U41"
    static let userRegisterPending = "U39"
}
