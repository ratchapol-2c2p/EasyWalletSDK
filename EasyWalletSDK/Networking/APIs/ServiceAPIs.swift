//
//  ServiceAPIs.swift
//  Alamofire
//
//  Created by Ratchapol Pattarakanoksiri on 7/10/2567 BE.
//

import Foundation
import Alamofire

enum ServiceApiType {
    case verifyUserByEmail
    case getConsentList
    case zolozInitial
    case zolozCheckResult
    case zolozInitialFaceCapture
    case zolozCheckResultFaceCapture
    case getOccupations
    case getBusinesstypes
    case getWalletpurposes
    case getOTP
    case verifyOTP
    case getCountries
    case getProvinces
    case getDistricts
    case getSubDistricts
    case none
 
}

struct ServiceApis {
    static func getPath(_ type: ServiceApiType) -> String {
        let apiVersion = Environment.apiVersion
        switch type {
        case .verifyUserByEmail: 
            return "/gac/api/\(apiVersion)/customers/verify-user-login-by-email"
        case .getConsentList: 
            return "gac/api/\(apiVersion)/pdpa/consents"
        case .zolozInitial:
            return "gac/api/\(apiVersion)/zoloz/id-recognition/initialize"
        case .zolozCheckResult:
            return "gac/api/\(apiVersion)/zoloz/id-recognition/check-result"
        case .zolozInitialFaceCapture:
            return "gac/api/\(apiVersion)/zoloz/face-capture/initialize"
        case .zolozCheckResultFaceCapture:
            return "gac/api/\(apiVersion)/zoloz/face-capture/check-result"
        case .getOccupations:
            return "gac/api/\(apiVersion)/masterdata/occupations"
        case .getBusinesstypes:
            return "gac/api/\(apiVersion)/masterdata/businesstype"
        case .getWalletpurposes:
            return "gac/api/\(apiVersion)/masterdata/walletpurpose"
        case .getOTP:
            return "gac/api/\(apiVersion)/otp/request-otp-by-email"
        case .verifyOTP:
            return "gac/api/\(apiVersion)/otp/verify-by-email"
        case .getCountries:
            return "gac/api/\(apiVersion)/masterdata/countries"
        case .getProvinces:
            return "gac/api/\(apiVersion)/masterdata/provinces/th"
        case .getDistricts:
            return "gac/api/\(apiVersion)/masterdata/districts/th"
        case .getSubDistricts:
            return "gac/api/\(apiVersion)/masterdata/subdistricts/th"
        default:
            return ""
        }
    }
    
    static func getMethod(_ type: ServiceApiType) -> HTTPMethod {
        switch type {
        case .none : return .get
        default :
            return .post
        }
    }
}
