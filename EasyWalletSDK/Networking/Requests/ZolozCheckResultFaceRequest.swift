import Foundation
import Alamofire

struct ZolozCheckResultFaceRequest: BaseRequestProtocol {
       var transactionId: String?

       init(transactionId: String? = nil) {
           self.transactionId = transactionId
       }
}
