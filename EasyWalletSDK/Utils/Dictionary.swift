//
//  Dictionary.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import Foundation

extension Dictionary {
    
    func data(option: JSONSerialization.WritingOptions = .prettyPrinted) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: option)
    }
    static func += (left: inout Dictionary, right: Dictionary) {
        for (key, value) in right {
            left[key] = value
        }
    }
}
