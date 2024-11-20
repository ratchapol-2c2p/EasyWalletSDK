//
//  RegisterByEmailRouter.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 12/10/2567 BE.
//

import Foundation
import IQKeyboardManagerSwift

class RegisterByEmailRouter: BaseRouter {

    private let viewController: UIViewController!
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func toVerifyOTP(email: String,otpResponse : OTPResponse) {
        
        let storyboard = BaseConstants.getStoryboard(.verifyOTP)
        if let vc = storyboard.instantiateViewController(
            withIdentifier: "VerifyOTPViewController")
            as? VerifyOTPViewController
        {
            vc.email = email
            vc.otpResponse = otpResponse
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            DispatchQueue.main.async {
                IQKeyboardManager.shared.enable = true
                let topVC = Tools.getTopViewController()
                topVC?.present(nav, animated: true)
            }
        }
    }
}
