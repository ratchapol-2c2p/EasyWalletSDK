//
//  BaseResponse.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 7/10/2567 BE.
//

import Foundation

protocol BaseResponseProtocol: Decodable {
    var responseCode: String? { get }
    var responseDescription: String? { get }
}

extension BaseResponseProtocol {
//    var responseCode: String? {
//        if let msg = rawResponseCode, !msg.isEmpty {
//            return msg
//        } else if let msg = rawResponseCode2, !msg.isEmpty {
//            return msg
//        } else {
//            return nil
//        }
//    }
//    
//    var responseDescription: String? {
//        if let msg = rawResponseDescription, !msg.isEmpty {
//            return msg
//        } else if let msg = rawResDescriptionEN, !msg.isEmpty {
//            return msg
//        } else if let msg = rawResDescriptionTH, !msg.isEmpty {
//            return msg
//        } else {
//            return nil
//        }
//    }
    
    var responseCodeAndDesc: String? {
        return "\(responseDescription ?? "") (\(responseCode ?? ""))"
    }
}

struct BaseResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    
//    var rawResponseCode: String?
//    var rawResponseCode2: String?
//    var rawResponseDescription: String?
//    var rawResDescriptionEN: String?
//    var rawResDescriptionTH: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case rawResponseCode = "ResponseCode"
//        case rawResponseCode2 = "responseCode"
//        case rawResponseDescription = "responseDescription"
//        case rawResDescriptionEN = "resDescriptionEN"
//        case rawResDescriptionTH = "resDescriptionTH"
//    }
//    
//    var responseCode: String? {
//        if let msg = rawResponseCode, !msg.isEmpty {
//            return msg
//        } else if let msg = rawResponseCode2, !msg.isEmpty {
//            return msg
//        } else {
//            return nil
//        }
//    }
//    
//    var responseDescription: String? {
//        if let msg = rawResponseDescription, !msg.isEmpty {
//            return msg
//        } else if let msg = rawResDescriptionEN, !msg.isEmpty {
//            return msg
//        } else if let msg = rawResDescriptionTH, !msg.isEmpty {
//            return msg
//        } else {
//            return nil
//        }
//    }
}
