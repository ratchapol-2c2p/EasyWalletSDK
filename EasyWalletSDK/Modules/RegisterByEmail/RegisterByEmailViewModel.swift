//
//  RegisterByEmailViewModel.swift
//  EasyWalletSDK
//
//  Created by Ratchapol Pattarakanoksiri on 12/10/2567 BE.
//

import Foundation

class RegisterByEmailViewModel: BaseViewModel {
    
    var email: String = ""
    @Published var emailErrorMessage: String = ""
    @Published var otpResponse: OTPResponse?
 
 
    
    var consentList: [Consent] = []
    
    init(consentList: [Consent]? = nil) {
        self.consentList = consentList ?? []
    }
    
    public func validate() -> Bool {
        if email.isEmpty {
            emailErrorMessage = "Invalid Email"
        } else {
            emailErrorMessage = ""
        }
        
        return emailErrorMessage.isEmpty
    }
    
    
    public func doGetOTP(req: OTPRequest) {
           callOTP(request: req) { [weak self] in
               guard self != nil else { return }
           }
       }
    public func callVerifyEmail(completion: @escaping (RegisterByEmailViewModel.VerifyUser) -> ()) {
        let req = VerifyUserByEmailRequest(email: email)
        showLoading(isShow: true)
        NetworkService.requestApi(.verifyUserByEmail,
                                  request: req,
                                  completion: { [weak self] (res: VerifyUserByEmailResponse) in
            guard let self = self else { return }
            self.showLoading(isShow: false)
            switch res.responseCode {
            case "U02":
                completion(RegisterByEmailViewModel.VerifyUser.canRegister)
                break;
            default:
                completion(RegisterByEmailViewModel.VerifyUser.canNotRegister)
                AlertHelpers.showError(detail: res.responseCodeAndDesc)
            }
        }) { (error) in
            AlertHelpers.showError(detail: error.localizedDescription)
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
    enum VerifyUser {
        case canRegister
        case canNotRegister
    }

}
