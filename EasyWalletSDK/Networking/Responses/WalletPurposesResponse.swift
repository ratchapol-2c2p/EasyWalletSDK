//
//  WalletPurposesResponse.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//
import Foundation

struct WalletPurposeResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var walletPurposes: [WalletPurpose]?
}

struct WalletPurpose: Codable {
    var purposeId: Int?
    var purposeEN: String?
    var purposeTH: String?
   
}
