//
//  LoadingHelper.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 21/10/2567 BE.
//

import Foundation
import SVProgressHUD

class LoadingHelper {
    static func showLoading(isShow: Bool) {
        SVProgressHUD.setBackgroundColor(UIColor(colorName: .transGray) ?? .clear)
        if isShow {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
