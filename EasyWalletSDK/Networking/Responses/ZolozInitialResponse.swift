import Foundation

struct ZolozInitialResponse : BaseResponseProtocol {
    var responseCode: String?
    var responseDescription: String?
    var transactionId: String?
    var clientCfg: String?
}


