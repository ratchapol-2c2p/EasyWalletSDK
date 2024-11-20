//
//  BaseConstants.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 1/10/2567 BE.
//

import Foundation
import UIKit

class BaseConstants {
    static internal func getResourceBundle() -> Bundle? {
        let podBundle = Bundle(for: ConsentViewController.self)
        if let bundleURL = podBundle.url(forResource: "EasyWalletSDKResources",
                                         withExtension: "bundle"),
           let resourceBundle = Bundle(url: bundleURL) {
            return resourceBundle
        } else {
            return nil
        }
    }
    
    static internal func getStoryboard(_ storyboardName: StoryboardName) -> UIStoryboard {
        let storyboard = UIStoryboard(name: storyboardName.rawValue,
                                      bundle: BaseConstants.getResourceBundle())
        return storyboard
    }
}
