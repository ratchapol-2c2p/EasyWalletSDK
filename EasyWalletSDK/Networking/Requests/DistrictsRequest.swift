//
//  DistrictsRequest.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 13/11/2567 BE.
//

import Foundation
import Alamofire

struct DistrictsRequest: BaseRequestProtocol {
    var provinceId: Int?

    init(provinceId: Int) {
        self.provinceId = provinceId
      
    }
}
