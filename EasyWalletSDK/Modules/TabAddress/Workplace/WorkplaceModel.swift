//
//  WorkplaceModel.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//

import Foundation

class WorkplaceModel: BaseViewModel {
    
    @Published var otpResponse: OTPResponse?
    @Published var verifyOtpResponse: VerifyOTPResponse?
 
    func doGetOTP(req: OTPRequest) {
        callOTP(request: req) { [weak self] in
            guard self != nil else { return }
        }
    }
    
    func doVerifyOTP(req: VerifyOTPRequest) {
        callVerifyOTP(request: req) { [weak self] in
            guard self != nil else { return }
        }
    }
        
    private func callOTP(request: OTPRequest, completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.getOTP,
                                  request: request,
                                  completion: {[weak self] (res: OTPResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.otpResponse = res
           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
    
    private func callVerifyOTP(request: VerifyOTPRequest, completion: @escaping CompletionBlock) {
        self.showLoading(isShow: true)
        NetworkService.requestApi(.verifyOTP,
                                  request: request,
                                  completion: {[weak self] (res: VerifyOTPResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            self.verifyOtpResponse = res
           
            completion()
        }) { [weak self] (error) in
            self?.showLoading(isShow: false)
            AlertHelpers.showError(detail: error.localizedDescription)
        }
    }
}
