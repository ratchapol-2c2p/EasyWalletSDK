//
//  OccupationResponse.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//
import Foundation

struct OccupationResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var occupations: [Occupation]?
}

struct Occupation: Codable {
    var id: Int?
    var name: String?
    var nameTH: String?
   
}

