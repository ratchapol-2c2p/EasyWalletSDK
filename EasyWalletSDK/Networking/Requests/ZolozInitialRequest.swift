import Foundation
import Alamofire

struct ZolozInitialRequest: BaseRequestProtocol {
       var metaInfo: String?
       var userId: String?
       var docType: String?

       init(metaInfo: String? = nil, userId: String? = nil, docType: String? = nil) {
           self.metaInfo = metaInfo
           self.userId = userId
           self.docType = docType
       }
}
