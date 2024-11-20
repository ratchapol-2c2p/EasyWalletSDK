//
//  EasyWalletSDK.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 29/5/2567 BE.
//
import Foundation
import UIKit
import IQKeyboardManagerSwift

public struct EasyWalletSDK {
    
    public init(environment: Environment = .sandbox) {
        Environment.currentEnvironment = environment
    }
    
    // MARK: Public
    public func registerWallet() {
        //        OauthToken {
        //            let storyboard = BaseConstants.getStoryboard(.consent)
        //            if let vc = storyboard.instantiateViewController(withIdentifier: "ConsentViewController") as? ConsentViewController {
        //
        //                vc.viewModel = ConsentViewModel()
        //
        //                let nav = UINavigationController(rootViewController: vc)
        //                nav.modalPresentationStyle = .fullScreen
        //
        //                DispatchQueue.main.async {
        //                    IQKeyboardManager.shared.enable = true
        //                    let topVC = Tools.getTopViewController()
        //                    topVC?.present(nav, animated: true)
        //                }
        //            }
        //        }

      
//        OauthToken {
//            let storyboard = BaseConstants.getStoryboard(.instructionOCR)
//            if let vc = storyboard.instantiateViewController(
//                withIdentifier: "InstructionOCRViewController")
//                as? InstructionOCRViewController
//            {
//                let nav = UINavigationController(rootViewController: vc)
//                nav.modalPresentationStyle = .fullScreen
//                
//                DispatchQueue.main.async {
//                    IQKeyboardManager.shared.enable = true
//                    let topVC = Tools.getTopViewController()
//                    topVC?.present(nav, animated: true)
//                }
//            }
//        }
     
        /*
       
        OauthToken {
            let storyboard = BaseConstants.getStoryboard(.register)
            if let vc = storyboard.instantiateViewController(
                withIdentifier: "RegisterByEmailViewController")
                as? RegisterByEmailViewController
            {
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                
                DispatchQueue.main.async {
                    IQKeyboardManager.shared.enable = true
                    let topVC = Tools.getTopViewController()
                    topVC?.present(nav, animated: true)
                }
            }
        }
        
         */
      
        OauthToken {
            let storyboard = BaseConstants.getStoryboard(.tabAddress)
            if let vc = storyboard.instantiateViewController(
                withIdentifier: "TabAddressViewController")
                as? TabAddressViewController
            {
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                
                DispatchQueue.main.async {
                    IQKeyboardManager.shared.enable = true
                    let topVC = Tools.getTopViewController()
                    topVC?.present(nav, animated: true)
                }
            }
        }
      
     
        
        //TabAddressViewController/
    }
    
    // MARK: Private
    private func OauthToken(completion: @escaping CompletionBlock) {
        NetworkService.getOauthToken { oauthResponse in
            completion()
        } failureBlock: { error in
            print(error.localizedDescription)
        }
    }
}








