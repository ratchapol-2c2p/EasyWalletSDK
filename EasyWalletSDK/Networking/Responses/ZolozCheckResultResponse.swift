import Foundation

struct ZolozCheckResultResponse : BaseResponseProtocol {
    var idInfo: IdInfo?
    var responseCode: String?
    var responseDescription: String?
}

struct IdInfo: Codable {
    var recognitionResult: String?
    var imageContent: [String]?
    var ocrResult: OCRResult?
    var spoofResult: SpoofResult?

}

struct OCRResult: Codable {
    var COUNTRY_CODE_IN_ISO: String?
    var ID_NUMBER: String?
    var MAC_ID: String?
    var COUNTRY: String?
    var SEX: String?
    var LAST_NAME: String?
    var DATE_OF_BIRTH: String?
    var HK_ID: String?
    var FIRST_NAME: String?
    var EXPIRY_DATE: String?
    var COUNTRY_CODE: String?
    var EFIRST_NAME_FULL: String?
    var EFIRST_NAME: String?
    var ELAST_NAME: String?
    var FIRST_NAME_FULL: String?
    var DATE_OF_EXPIRY: String?
    var LASER_NUMBER: String?
    var ADDRESS: String?
    var TNAME: String?
    var DATE_OF_ISSUE: String?
}

struct SpoofResult: Codable {
    var TAMPER_CHECK: String?
    var MATERIAL_CHECK: String?
    var SCREEN_RECAPTURE_CHECK: String?
    var SECURITY_FEATURE_CHECK: String?
    var INFORMATION_CHECK: String?
}
