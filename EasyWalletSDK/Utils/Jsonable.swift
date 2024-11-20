//
//  Jsonable.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 7/10/2567 BE.
//

import Foundation

protocol Jsonable: Encodable {
    func toJson() -> [String: Any]?
}

extension Jsonable {
    func toJson() -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self), let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dict
    }
}
