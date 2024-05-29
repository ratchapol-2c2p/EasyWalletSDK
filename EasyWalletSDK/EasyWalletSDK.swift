//
//  EasyWalletSDK.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 29/5/2567 BE.
//
import Foundation

public struct EasyWalletSDK {
    
    static var sayHelloText: String?
    
    public init(_sayHelloText: String) {
        EasyWalletSDK.sayHelloText = _sayHelloText
    }
    
    public static func sayHello() {
        print(EasyWalletSDK.sayHelloText ?? "")
    }
}
