//
//  ImageNames.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 17/10/2567 BE.
//

import UIKit

enum ImageNames: String {
    case arrowBackWhiteIcon = "ic_arrow_back_white"
    case checkActiveIcon = "check_active"
    case radioActiveIcon = "ic_radio_active"
    case radioInActiveIcon = "ic_radio_inactive"
    case thaiIdCardImage = "img_thai_id_card"
    case passPortImage = "img_passport"
    case tickGreenIcon = "icon_green_tick"
    case selfieImage = "img_selfie"
    case arrowDownIcon = "ic_arrow_down"
    case dateIcon = "ic_date"
    case checkInActiveIcon = "check_in_active"
    case backIcon = "ic_back"
    case nextIcon = "ic_next"
    
}

extension UIImage {
    convenience init?(imageNames: ImageNames) {
        self.init(named: imageNames.rawValue,
                  in: BaseConstants.getResourceBundle(),
                  compatibleWith: nil)
    }
    
    convenience init?(named: String) {
        self.init(named: named, in: BaseConstants.getResourceBundle(), compatibleWith: nil)
    }
}
