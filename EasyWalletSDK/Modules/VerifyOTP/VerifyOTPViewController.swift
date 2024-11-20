//
//  VerifyOTPViewController.swift
//  Pods
//
//  Created by Tanawat Arthan on 2/11/2567 BE.
//

import UIKit
import OTPFieldView

class VerifyOTPViewController: BaseViewController, OTPFieldViewDelegate {
    
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    @IBOutlet weak var otpPrefixUILabel: UILabel!
    @IBOutlet weak var emailUILabel: UILabel!
    @IBOutlet weak var acceptUIButton: UIButton!
    
    
    var router: VerifyOTPRouter!
    var viewModel: VerifyOTPModel!
    var email: String?
    var otpResponse: OTPResponse?
    var otp: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar(title: "Verify OTP")
        router = VerifyOTPRouter(self)
        viewModel = VerifyOTPModel()
        setupUI()
        bindViewModel()
        
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        self.otp = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {

        acceptUIButton.isEnabled = hasEntered
        acceptUIButton.backgroundColor = hasEntered ?UIColor.init(colorName: .primary): UIColor.init(colorName: .gray)
        
        return false
    }
    
    private func bindViewModel() {
        SessionHelper.shared.email = email
        viewModel.$otpResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] otpResponse in
                guard self != nil else {return}
                if let response = otpResponse {
                    switch(response.responseCode) {
                        case "000":
                            self?.otpPrefixUILabel.text = "\(response.otpPrefix ?? "")"
                        break
                        default :
                            AlertHelpers.showError(detail: response.responseDescription)
                        break
                    }
                   
                }
            }
            .store(in: &cancellables)
        
        viewModel.$verifyOtpResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] verifyOtpResponse in
                guard self != nil else {return}
                if let response = verifyOtpResponse {
                    switch(response.responseCode) {
                        case "000":
                            print("=======> ? \(response.responseCode ?? "")")
                            print("=======>Has entered all OTP? \(response.verificationCode ?? "")")
                            SessionHelper.shared.verificationCode = response.verificationCode
                            self?.router.toInstructionOCRPage()
                        break
                        default :
                            AlertHelpers.showError(detail: response.responseDescription)
                        break
                  
                    }
                }
            }
            .store(in: &cancellables)

    }
    private func setupUI() {
        
        self.emailUILabel.text = self.email
        self.otpPrefixUILabel.text = otpResponse?.otpPrefix
        self.acceptUIButton.isEnabled = false
        self.acceptUIButton.backgroundColor = UIColor.init(colorName: .gray)
        
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = UIColor.gray
        self.otpTextFieldView.filledBorderColor = UIColor(colorName: .primary)!
        self.otpTextFieldView.cursorColor = UIColor(colorName: .primary)!
        self.otpTextFieldView.displayType = .underlinedBottom
        self.otpTextFieldView.fieldSize = 40
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = true
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
        self.otpTextFieldView.otpInputType = .numeric
        
    }
    @IBAction func onTouchAcceptButton(_ sender: Any) {
        
        let req = VerifyOTPRequest(email: self.email ?? "",otpPrefix: self.otpPrefixUILabel.text ?? "",otpValue:self.otp ?? "")
        viewModel.doVerifyOTP(req:req)
       
    }
    
    @IBAction func onTouchResendOTPButton(_ sender: Any) {
        let req = OTPRequest(email: self.email ?? "", languageCode:"EN")
        viewModel.doGetOTP(req:req)
    }

}
