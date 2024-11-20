//
//  RawResponse.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 8/10/2567 BE.
//

import Foundation

protocol RawResponseProtocol: Codable {
    var responseCode: String? { get set }
    var responseDescription: String? { get set }
    var data: String? { get set }
}

extension RawResponseProtocol {
    
}

struct RawResponse: RawResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var data: String?
}
