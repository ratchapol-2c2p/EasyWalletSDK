//
//  ResponseSerializer.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 3/10/2567 BE.
//

//import Alamofire
//
//class ResponseSerializer: NSObject {
//    var response:[String:Any]?
//    var error:ErrorEvent?
//    
//    init(from response: Any) {
//        print("JSON RESPONSE: \(response)")
//        if let res = response as? [String: Any] {
//            self.response = res
//        } else {
//            self.error = ErrorEvent.custom(message: "ResponseSerializer Error")
//        }
//        //        switch response.result {
//        //        case .success(let data):
////        guard let res = response as? [String: Any] else {
////            self.error = ErrorEvent.response
////            return
////        }
//        
////        if let res = response as? [String: Any] {
////            if let msg = res["Message"] as? String {
////                self.error = ErrorEvent.custom(message: msg)
////            } else {
////                print("\nREST Response: \(res)\n")
////                self.response = res
////            }
////        } else if let res = response as? [[String: Any]] {
////            print("\nREST Response: \(res)\n")
////            let tmp: [String: [[String: Any]]] = ["list": res]
////            self.response = tmp
////        } else {
////            self.error = ErrorEvent.response
////            return
////        }
//        
//        
//        
//        //        case .failure(let error):
//        //            print("Error Reason: \(error.localizedDescription)")
//        //            self.error = ErrorEvent.custom(message: error.localizedDescription)
//        //        }
//    }
//}
