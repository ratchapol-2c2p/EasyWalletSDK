//
//  ConsentListResponse.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 10/10/2567 BE.
//

import Foundation

struct ConsentListResponse: BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var consentList: [Consent]?
}

struct Consent: Codable {
    var consentId: Int?
    var acceptFlag: Bool?
    var consentStr1: String?
    var consentStr2: String?
    var consentVersion: String?
    var consentLink: String?
    var companyCode: String?
    var consentType: String?
    var functionCode: String?
    var startDate: String?
    var endDate: String?
    var scheduleFlag: Bool?
    var forceAcceptFlag: Bool?

    func getTitle(context: UIViewController) -> String {
        switch consentType {
        case "CT01":
            return "Terms and Conditions"
        case "CT02":
            return "Privacy Policy"
        case "CT03":
            return "Terms & Conditions for Physical Card"
        case "CT04":
            return "Marketing & Consent"
        default:
            return "Terms and Conditions"
        }
    }

    func getTitleCheckBox(context: UIViewController) -> String {
        switch consentType {
        case "CT01":
            return "I accept all of Terms & Conditions"
        case "CT02":
            return "I accept for the Privacy Policy"
        case "CT03":
            return "I accept the Terms & Conditions for Physical Card"
        case "CT04":
            return "I accept the Marketing & Consent"
        default:
            return "I accept all of Terms & Conditions"
        }
    }
}
