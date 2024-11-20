//
//  AlertHelper.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 8/10/2567 BE.
//

import Foundation
import UIKit

class AlertHelpers {
    
    static func show(title: String? = nil,
                     detail: String? = nil,
                     okAction: CompletionBlock? = nil) {
        let storyboard = BaseConstants.getStoryboard(.alert)
        guard let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController else {
            print("Can't init AlertViewController")
            return
        }
        alertVC.titleText = title
        alertVC.detailText = detail
        alertVC.okTitle = "OK"
        alertVC.okAction = okAction
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.modalPresentationStyle = .overCurrentContext
        DispatchQueue.main.async {
            let topVC = Tools.getTopViewController()
            topVC?.present(alertVC, animated: true, completion: nil)
            UIView.animate(withDuration: 1.0, animations: {
                alertVC.view.alpha = 1.0
            }, completion: { finished in
            })
        }
    }
    
    static func showError(detail: String? = nil, okAction: CompletionBlock? = nil) {
        AlertHelpers.show(title: "Error", detail: detail, okAction: okAction)
    }
}

class Tools {
    static func getTopViewController() -> UIViewController? {
        guard let keyWindow = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow }) else {
            print("No key window found")
            return nil
        }

        var topController = keyWindow.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        
        return topController
    }
}
