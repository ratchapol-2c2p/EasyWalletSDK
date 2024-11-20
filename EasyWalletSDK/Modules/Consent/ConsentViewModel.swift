//
//  ConsentViewModel.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 9/10/2567 BE.
//

import Foundation
import Combine
import SVProgressHUD

class ConsentViewModel: BaseViewModel {
    
    @Published var displayConsent: Consent?
    @Published var isAccept: Bool = false
    
    var consentList: [Consent] = []
    var selectedIndex: Int?
    
    init(consentList: [Consent]? = nil,
         selectedIndex: Int? = nil) {
        self.consentList = consentList ?? []
        self.selectedIndex = selectedIndex
    }
    
    func getConsent() {
        if consentList.count > 0 {
            displayConsent = self.consentList[selectedIndex ?? 0]
        } else {
            callGetConsentList { [weak self] in
                guard let self = self else { return }
                self.selectedIndex = 0
                displayConsent = self.consentList[selectedIndex ?? 0]
            }
        }
    }
    
    func acceptConsent(_ isAccept: Bool) {
        consentList[selectedIndex ?? 0].acceptFlag = isAccept
    }
    
    func getNextConsentIndex() -> Int? {
        let nextIndex = (selectedIndex ?? 0) + 1
        return consentList.count > nextIndex ? nextIndex : nil
    }
    
    private func callGetConsentList(completion: @escaping CompletionBlock) {
        let req = ConsentListRequest(language: "EN")
        showLoading(isShow: true)
        NetworkService.requestApi(.getConsentList,
                                  request: req,
                                  completion: { [weak self] (res: ConsentListResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.consentList = res.consentList ?? []
            completion()
        }) { (error) in
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
}
