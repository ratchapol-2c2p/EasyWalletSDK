//
//  ProvinceResponse.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 13/11/2567 BE.
//


struct ProvincesResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var provinces: [Provinces]?
    
}

struct Provinces: Codable {
    var id: Int?
    var name: String?
    var nameTH: String?
}
