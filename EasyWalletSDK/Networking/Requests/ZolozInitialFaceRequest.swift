import Foundation
import Alamofire

struct ZolozInitialFaceRequest: BaseRequestProtocol {
       var metaInfo: String?
       var userId: String?

       init(metaInfo: String? = nil, userId: String? = nil) {
           self.metaInfo = metaInfo
           self.userId = userId
       }
}
