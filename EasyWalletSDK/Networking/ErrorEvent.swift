//
//  ErrorEvent.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import UIKit

enum ErrorEvent: Error {
    case parsing
    case request
    case response
    case invalid
    case unexpected
    case custom(message:String?)
    
    var localizedDescription: String {
        switch self {
        case .parsing:              return "Parsing Error"//"Parsing Error"
        case .request:              return "Request Error"//"Request Error"
        case .response:             return "Response Error"//"Response Error"
        case .invalid:              return "Invalid Error"//"Invalid Error"
        case .unexpected:           return "Unexpected"//"Unexpected Error"
        case .custom(let message):
            return message ?? "Unknown Error"//"Unknown Error"
        }
    }
}
