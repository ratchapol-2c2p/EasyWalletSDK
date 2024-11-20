//
//  BusinesstypeResponse.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//
import Foundation

struct BusinessTypeResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var businessTypes: [BusinessType]?
}

struct BusinessType: Codable {
    var businessTypeId: Int?
    var businessTypeEN: String?
    var businessTypeTH: String?
   
}
