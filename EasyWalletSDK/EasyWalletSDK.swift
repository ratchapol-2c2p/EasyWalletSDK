//
//  EasyWalletSDK.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 29/5/2567 BE.
//
import Foundation
import UIKit

public struct EasyWalletSDK {
    var controller: UIViewController?
    
    public init(controller: UIViewController) {
        self.controller = controller
    }
    
    public func showSDKViewController() {
        let storyboard = BaseConstants.getStoryboard("Main")
        let vc = storyboard.instantiateViewController(withIdentifier: "StartViewController")
        DispatchQueue.main.async {
            controller?.present(vc, animated: true)
        }
    }
}
