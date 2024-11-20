//
//  RegisterByEmailViewModel.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 12/10/2567 BE.
//

import Foundation

class InstructionOCRModel: BaseViewModel {
    
    @Published var zolozresponse: ZolozInitialResponse?
    @Published var zolozCheckResultResponse: ZolozCheckResultResponse?
 
    func initialZoloz(req: ZolozInitialRequest) {
        callZolozInitial(request: req) { [weak self] in
            guard self != nil else { return }
        }
    }
    func doGetZolozCheckResult(req: ZolozCheckResultRequest) {
        callZolozCheckResult(request: req) { [weak self] in
            guard self != nil else { return }
        }
    }
        
    private func callZolozInitial(request: ZolozInitialRequest, completion: @escaping CompletionBlock) {
        showLoading(isShow: true)
        NetworkService.requestApi(.zolozInitial,
                                  request: request,
                                  completion: { [weak self] (res: ZolozInitialResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.zolozresponse = res
            completion()
        }) { (error) in
            self.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }

    private func callZolozCheckResult(request: ZolozCheckResultRequest, completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.zolozCheckResult,
                                  request: request,
                                  completion: {[weak self] (res: ZolozCheckResultResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.zolozCheckResultResponse = res
           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
}
