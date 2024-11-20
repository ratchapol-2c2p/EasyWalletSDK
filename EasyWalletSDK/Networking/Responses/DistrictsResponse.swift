//
//  DistrictsResponse.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 13/11/2567 BE.
//


struct DistrictsResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var districts: [Districts]?
    
}

struct Districts: Codable {
    var id: Int?
    var name: String?
    var nameTH: String?
}
