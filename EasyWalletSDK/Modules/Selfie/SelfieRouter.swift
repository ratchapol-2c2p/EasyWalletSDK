//
//  ConsentRouter.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 9/10/2567 BE.
//

import Foundation

class SelfieRouter: BaseRouter {

    private let viewController: UIViewController!
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func toPersonalInformationPage() {
        
        let storyboard = BaseConstants.getStoryboard(.personalInformation)
        if let vc = storyboard.instantiateViewController(withIdentifier: "PersonalInformationViewController") as? PersonalInformationViewController {
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
   
    
}
