//
//  ConsentRouter.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 9/10/2567 BE.
//

import Foundation

class ConsentRouter: BaseRouter {

    private let viewController: UIViewController!
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func toConsentPage(consentList: [Consent], selectedIndex: Int) {
        let storyboard = BaseConstants.getStoryboard(.consent)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ConsentViewController") as? ConsentViewController {
            
            vc.viewModel = ConsentViewModel(consentList: consentList,
                                            selectedIndex: selectedIndex)
            viewController.navigationController?.pushViewController(vc, animated: true)
//            DispatchQueue.main.async {
//                viewController.navigationController?.pushViewController(vc, animated: true)
//            }
        }
    }
    
    func toRegisterPage(consentList: [Consent]) {
        let storyboard = BaseConstants.getStoryboard(.register)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RegisterByEmailViewController") as? RegisterByEmailViewController {
            
            vc.viewModel = RegisterByEmailViewModel(consentList: consentList)
            
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
