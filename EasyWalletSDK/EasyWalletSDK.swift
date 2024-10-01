//
//  EasyWalletSDK.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 29/5/2567 BE.
//
import Foundation
import UIKit

public struct EasyWalletSDK {
    
    var sayHelloText: String?
    var controller: UIViewController?
    
    public init(controller: UIViewController, sayHelloText: String) {
        self.sayHelloText = sayHelloText + sayHelloText
        self.controller = controller
    }
    
    public func sayHello() {
        print(sayHelloText ?? "")
    }
    
    public func showSDKViewController() {
        let storyboard = BaseConstants.getStoryboard("Main")
        let vc = storyboard.instantiateViewController(withIdentifier: "StartViewController")
        DispatchQueue.main.async {
            controller?.present(vc, animated: true)
        }
    }
}
