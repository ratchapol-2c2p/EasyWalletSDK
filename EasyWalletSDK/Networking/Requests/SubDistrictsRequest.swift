//
//  DistrictsRequest.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 13/11/2567 BE.
//

import Foundation
import Alamofire

struct SubDistrictsRequest: BaseRequestProtocol {
    var districtId: Int?

    init(districtId: Int) {
        self.districtId = districtId
      
    }
}
