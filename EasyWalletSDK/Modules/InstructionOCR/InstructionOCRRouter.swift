//
//  ConsentRouter.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 9/10/2567 BE.
//

import Foundation

class InstructionOCRRouter: BaseRouter {

    private let viewController: UIViewController!
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func toSelfiePage() {
        let storyboard = BaseConstants.getStoryboard(.selfie)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SelfieViewController") as? SelfieViewController {
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
