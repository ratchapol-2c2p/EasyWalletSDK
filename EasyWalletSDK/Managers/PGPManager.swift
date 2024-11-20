//
//  PGPManager.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 7/10/2567 BE.
//

import Foundation
import ObjectivePGP

class PGPManager {
    internal func encrypt(data: [String: Any]) -> String? {
        let publicKey: String = pgpFormatted(
            beginText: "BEGIN PGP PUBLIC KEY BLOCK",
            endText: "END PGP PUBLIC KEY BLOCK",
            key: Environment.gacPGPEncryptKey.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "")
          );
        
        if let publicKeyData = publicKey.data(using: .utf8) {
            do {
            
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                print("===========>Request Data : ")
                print(String(data: jsonData, encoding: .utf8) ?? "")
        
                let keys = try ObjectivePGP.readKeys(from: publicKeyData)
                let encryptedData = try ObjectivePGP.encrypt(jsonData,
                                                             addSignature: false,
                                                             using: keys)
                let encryptedString = encryptedData.base64EncodedString()
                return encryptedString
            } catch {
                return nil
            }
        }
        return nil
    }
    
    internal func decrypt(data: String) -> String? {
//        let test = "hQEMA7HUP/S/7UH8AQgAocH8prDF2b2zST15VmJWwGn8E0jroYqrfJKTvIMJ9hU1zR7e2cx+Gfquqf/ZPxoEhrNwuSzOGNFcvpiXei+sqvAyNe1iZ3dGI/Oc8bx+TFJoq1rBT3wyKMyViWoIQvstRAqhPwSE844AcHRD2vQu38vxGFcceDH50NTLNFc1QBdodOwEjReKIjjQCxAn4zypAJEMh46HLy5ZX291NJyuJecoI270HtiposbvNNlRcIiRnoaQ4nwcEPqBZeEHRgBU7pX8tg3Ft7lHsgsU1bjsF+kKdR2ygcBzQUbqLaBhaU1d3MKQjHEgRhNBO1abvXiEWl1wO/G0aXQpLw3HMaYfTdJrAUrG+YZgInTWeeWiBg6kut2aBc7Q5vs7eYm8ssM945ByBxjvbli+l41GmR0Lw5c0wtgJzFB3+lueUJP1NrhJn4MeD3rzKvpRfSeoQWU0bfKHBLU+hX1KZfAA8wzEdW6JRMJ20s5iit0ce3k==uqol"
        
//        let test = "hQEMA7HUP/S/7UH8AQgAi9w+At6bUUdZI9CYAuS20L0FIBC5TeAKDetUboyVZzjd6tMoOzGOKlLb+eufJjwGmBXNDG9RgYFx9/5wITIZJpw6TFyub6WcQ/+BHRTrAf1Z1EF5TlK1OqMSr9LAoCGtjIVTIY8SAeRl3HW3FuwrWOG/UXt1C2qPc8qsQKT9B0paN9XL7W7p2trYBdQHgxBKvr4h0XYfb0wux7GPtQo6xrxkA7NJz8Ya3oj9JykwioXQGzFHgPlR93J1RRLxxiAfYfzNRQGyaj+iMyUjGvRz2ckU/gRFtv4qw1aZpsGWz1OQp4bNhvo2+vXerymQldJdxelA3W4MtlPQvOusUIpn5NJrAd9djQXQztNrjexH0LBgQSPmwTYoPEM2esTfqVNRIEEKiqrqerM8gVxLUSkDuk11mounWqRVqLiJy38eOJDXEbo3T0RZbWbkfHr2JUDdC5L45BLww7+47SngHgO7bzNg2AOTUorlGiQqDCM==QdiC"
        
//        let test = "hQEMA7HUP/S/7UH8AQf+K6Qz4KA11fTnEUw27zt+Tmn8039aNUjQyW49wrFX8BF4vUA+03zi+WNJrhb9ghixoFbLeqO4wBxQG7SgDUZIc33JVhj4jNbrr8AfU9QVv/04pJeYeS0fCiuu8ave2jD7qi5zzQo4bAgJJWBvAQWpHYOyjoz/PFRcI2yzp39iV9aDlR4b1EOK4N2BanxW188/JQHtN1Bn+TwrGmPStPyx5ShglQUL3UjhQTaYRCljLiYaq0yBk0OIKJYuc8Ml8JKb3t13J+3tgMvcY2d9Yy0Yg1mZ/+AmC8QkO76MdfTeObjNYPfsZm/vgPZ0T442p1MtdE8/uZrJ/wjCQ+78+hyW+9J9Aa41i4Oe2VEKwzQNXfoxSx88z6ITnMyLUU3TDBBCzddEcIWzNNbQzsmv/xgfDZDMnzX3uuveVVPIoReG9Vsgtscy8+J+lzkn7LkgeWHh6yI9r1RvVIT9u+2+A4zH7bHkaLQSr9IjSoHyTXISkabsIwTyXMxINeu7hKQ8VH8==SisJ"
        
        
        
        let privateKey = pgpFormatted(
            beginText: "BEGIN PGP PRIVATE KEY BLOCK",
            endText: "END PGP PRIVATE KEY BLOCK",
            key: Environment.gacPGPDecryptKey.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: ""),
            isNeedCheckSum: false
        )
        
        let dataArmor = pgpFormatted(
            beginText: "BEGIN PGP MESSAGE",
            endText: "END PGP MESSAGE",
            key: data
        )
        
        do {
            let privateKeyData = privateKey.data(using: .utf8)!
            let keys = try ObjectivePGP.readKeys(from: privateKeyData)
        
            let messageData = dataArmor.data(using: .utf8)!
            
            let decryptedData = try ObjectivePGP.decrypt(messageData, andVerifySignature: false, using: keys, passphraseForKey: { key in
                return Environment.gacPGPDecryptPassword
            })
            
            // แปลง Data ที่ถอดรหัสเป็น String
            if let decryptedString = String(data: decryptedData, encoding: .utf8) {
                
                print("===========>Decrypt : \n\(decryptedString)")
                print("\n")
                print("==========================================")
                return decryptedString
            } else {
                throw NSError(domain: "DecryptionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert decrypted data to string."])
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    private func pgpFormatted(beginText: String, endText: String, key: String, isNeedCheckSum: Bool = true) -> String {
        let maxCharacter = 64
        var formattedText = ""
        
        let data = key.replacingOccurrences(of: "\n", with: "")
        var currentIndex = data.startIndex
        while currentIndex < data.endIndex {
            let endIndex = data.index(currentIndex, offsetBy: maxCharacter, limitedBy: data.endIndex) ?? data.endIndex
            formattedText += data[currentIndex..<endIndex] + "\n"
            currentIndex = endIndex
        }
        
        if isNeedCheckSum && formattedText.count >= 6 {
            let checkSum = formattedText.suffix(6)
            let prepared = formattedText.dropLast(6)
            formattedText = "\(prepared)\n\(checkSum)"
        }

        return """
        -----\(beginText)-----
        Version: openpgp-mobile

        \(formattedText.trimmingCharacters(in: .whitespacesAndNewlines))
        -----\(endText)-----
        """
    }

}
