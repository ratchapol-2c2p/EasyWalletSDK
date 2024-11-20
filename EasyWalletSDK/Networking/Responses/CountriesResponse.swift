//
//  CountriesResponse.swift
//  Pods
//
//  Created by Tanawat Arthan on 13/11/2567 BE.
//

struct CountriesResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var countries: [Countries]?
    
}

struct Countries: Codable {
    var numeric: String?
    var codeA2: String?
    var codeA3: String?
    var name: String?
    var nameTH: String?

}
