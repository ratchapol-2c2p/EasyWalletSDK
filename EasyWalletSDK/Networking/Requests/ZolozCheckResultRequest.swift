import Foundation
import Alamofire

struct ZolozCheckResultRequest: BaseRequestProtocol {
       var transactionId: String?

       init(transactionId: String? = nil) {
           self.transactionId = transactionId
       }
}
