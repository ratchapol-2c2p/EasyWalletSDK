import Foundation

struct ZolozCheckResultFaceResponse : BaseResponseProtocol {
    var zolozErrorDescription: String?
    var faceInfo: FaceInfo?
    var responseCode: String?
    var responseDescription: String?
}

struct FaceInfo: Codable {
    var imageContent: String?
    var faceAttack: Bool?
    var quality: Double?
}
