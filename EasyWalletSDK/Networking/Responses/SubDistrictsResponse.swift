//
//  SubDistrictsResponse.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 13/11/2567 BE.
//


struct SubDistrictsResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var subDistricts: [SubDistricts]?
    
}

struct SubDistricts: Codable {
    var id: Int?
    var name: String?
    var nameTH: String?
}
