//
//  MailingRouter.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//


import Foundation

class MailingRouter: BaseRouter {

    private let viewController: UIViewController!
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func toInstructionOCRPage() {
        let storyboard = BaseConstants.getStoryboard(.instructionOCR)
        if let vc = storyboard.instantiateViewController(withIdentifier: "InstructionOCRViewController") as? InstructionOCRViewController {
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
