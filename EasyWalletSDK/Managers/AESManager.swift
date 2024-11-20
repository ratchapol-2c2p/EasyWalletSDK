//
//  AESManager.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 7/10/2567 BE.
//

import Foundation
import CryptoSwift

internal class AES256Manager {
    static func encrypt(_ data: String) -> String? {
        do {
            let byteArray = data.utf8.map{UInt8($0)}
            
            let key = [UInt8](Data(base64Encoded: Environment.gacAesKey)!)
            let iv = [UInt8](Data(base64Encoded: Environment.gacAesIV)!)

            let encrypted = try AES(key: key,
                                    blockMode: CBC(iv: iv),
                                    padding: .pkcs7).encrypt(byteArray)
            
            return encrypted.toBase64()
        } catch let error {
            print(error)
        }
        return nil
    }
    
    static func decrypt(_ data: String) -> String? {
        do {
            guard let dataDecode = Data(base64Encoded: data) else {
                return nil
            }
            
            let byteArray = [UInt8](dataDecode)
            let key = [UInt8](Data(base64Encoded: Environment.gacAesKey)!)
            let iv = [UInt8](Data(base64Encoded: Environment.gacAesIV)!)
            
            let decrypted = try AES(key: key,
                                    blockMode: CBC(iv: iv),
                                    padding: .pkcs7).decrypt(byteArray)
            
            let decryptedData = Data(decrypted)
            if let decryptedString = String(data: decryptedData, encoding: .utf8) {
                return decryptedString
            } else {
                print("Failed to convert decrypted data to string.")
                return nil
            }
        } catch let error {
            print(error)
        }
        return nil
    }
}
