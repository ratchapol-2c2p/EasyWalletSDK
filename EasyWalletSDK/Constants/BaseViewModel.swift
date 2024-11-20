//
//  BaseViewModel.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 9/10/2567 BE.
//

import Foundation
import SVProgressHUD

class BaseViewModel {
    
    func showLoading(isShow: Bool) {
        LoadingHelper.showLoading(isShow: isShow)
    }
    
}
