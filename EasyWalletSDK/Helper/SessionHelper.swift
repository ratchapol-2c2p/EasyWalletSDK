//
//  SessionHelper.swift
//  EasyWalletSDK
//
//  Created by Tanawat Arthan on 5/11/2567 BE.
//

@propertyWrapper
struct StaticStorage<T> {
    private var value: T?
    
    var wrappedValue: T? {
        get { return value }
        set { value = newValue }
    }
}

class SessionHelper {
    @StaticStorage var verificationCode : String?
    @StaticStorage var email : String?
    @StaticStorage var isThai : Bool?
    @StaticStorage var zolozIdInfo : IdInfo?
    @StaticStorage var zolozfaceInfo : FaceInfo?
    @StaticStorage var countries : [Countries]?
    @StaticStorage var provinces : [Provinces]?

    static let shared = SessionHelper()
    private init() {}
}
