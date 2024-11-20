//
//  OAuthResponse.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import UIKit

struct OAuthResponse: Codable {
    var accessToken: String?
    var expiresIn: Int?
    var tokenType: String?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case error = "error"
    }
}
