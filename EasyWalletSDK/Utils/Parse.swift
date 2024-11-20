//
//  Parse.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

import Foundation

struct Parse {
    
    static func jsonGenericObject<T: Decodable>(with responses:[String: Any], type: T.Type) -> T? {
        guard let jsonData = try? responses.data() else {  return nil  }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            return result
            
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func fromJsonString<T: Decodable>(_ json: String, type: T.Type) -> T? {
        guard let jsonData = json.data(using: .utf8) else {  return nil  }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            return result
            
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func jsonToDict(_ json: String) -> [String: Any]? {
        guard let jsonData = json.data(using: .utf8) else {  return nil  }
        
        do {
            let result = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            return result
            
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func jsonObjectToJsonString(jsonObject: [String: Any]?) -> String? {
        guard let jsonObject = jsonObject else { return nil }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("Error converting JSON object to string: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func convertToDictionary(from object: Codable) -> [String: Any]? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(object)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonObject as? [String: Any]
        } catch {
            print("Error encoding object: \(error)")
            return nil
        }
    }
    
    static func stringToDicionary(_ jsonString: String) -> [String: Any]? {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                // แปลง JSON เป็น [String: Any] โดยใช้ JSONSerialization
                if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    return(jsonObject)
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}
